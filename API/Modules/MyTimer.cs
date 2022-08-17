using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sensor.API.Data;
using Sensor.API.Models;
using Sensor.API.Models.DTO;
using Sensor.API.Controllers;

namespace Sensor.API.Modules
{
    public class ImplementBackgroundService : BackgroundService
    {

        private readonly AppDbContext _context;
        private readonly IMapper _mapper;

        public ImplementBackgroundService(AppDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {

            while (!stoppingToken.IsCancellationRequested)
            {
                checkStatusEvery5Minute();
                await Task.Delay(300000);
            }
        }

        public void checkStatusEvery5Minute()
        {
            //todo get all devices and check
            var devices = _context.Devices.Select(r => r.Id).ToList();
            for(int i = 0; i < devices.Count; i++)
            {
                StatusDTO statusDTO = new StatusDTO();
                statusDTO.cihazId = devices[i];
                statusDTO.isActive = isActive(devices[i], DateTime.Now.AddMinutes(-5), DateTime.Now);
                statusDTO.Date = DateTime.Now;

                if (!statusDTO.isActive)
                {
                    var lastAlert = _context.DeviceStatuses.Where(r => r.deviceId == devices[i]).OrderBy(r=>r.Date).LastOrDefault();
                    if (lastAlert!=null && lastAlert.isActive)
                    {
                        Alert newAlert = new Alert();
                        newAlert.deviceId = (Int16)devices[i];
                        newAlert.message = "Can't recieve data for 5 minutes from device " + devices[i] + " !";
                        newAlert.type = "Error!";
                        newAlert.date = DateTime.Now;

                        _context.Alerts.AddAsync(newAlert);
                    }

                }
                else
                {
                    var lastAlert = _context.DeviceStatuses.Where(r => r.deviceId == devices[i]).OrderBy(r => r.Date).LastOrDefault();
                    if (lastAlert != null && !lastAlert.isActive)
                    {
                        Alert newAlert = new Alert();
                        newAlert.deviceId = (Int16)devices[i];
                        newAlert.message = "Succesfully recieving data from device "+ devices[i]+ " !";
                        newAlert.type = "Error!";
                        newAlert.date = DateTime.Now;

                        _context.Alerts.AddAsync(newAlert);
                    }

                }

                var record = _mapper.Map<DeviceStatus>(statusDTO);
                _context.DeviceStatuses.AddAsync(record);
            }
            _context.SaveChangesAsync();

            //
        }

        private bool isActive(int cihazId, DateTime start, DateTime end)
        {
            return _context.Records.Any(n => n.Date >= start && n.Date < end && n.cihazId == cihazId);
        }
    }
}