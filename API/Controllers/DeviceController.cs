using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sensor.API.Data;
using Sensor.API.Models;
using Sensor.API.Models.DTO;

namespace Sensor.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class DeviceController : ControllerBase
    {


        private readonly AppDbContext _context;
        private readonly IMapper _mapper;

        public DeviceController(AppDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }


        [HttpPost("addDevice")]
        public async Task<ActionResult> addDevice(DeviceDTO deviceDTO)
        {
            if (DeviceExist(deviceDTO))
            {
                return BadRequest();
            }

            var record = new Device();
            record.createDate = DateTime.Now;
            record.Id = deviceDTO.cihazId;
            record.name = deviceDTO.name;

            var status = new DeviceStatus();
            status.isActive = true;
            status.Date = DateTime.Now;
            status.cihazId=deviceDTO.cihazId;
            //todo -

            await _context.DeviceStatuses.AddAsync(status);

            await _context.Devices.AddAsync(record);
            await _context.SaveChangesAsync();

            return Ok();
        }

        private bool DeviceExist(DeviceDTO deviceDTO)
        {
            var deviceResult = _context.Devices.FirstOrDefault(u => u.Id == deviceDTO.cihazId);
            return deviceResult == null ? false : true;
        }


        [HttpGet("getAllDevices")]
        public async Task<IEnumerable<Device>> GetAllUsers()
        {
            var records = await _context.Devices.ToListAsync();
            return records;
        }

        [HttpGet("getAllIds")]
        public async Task<IEnumerable<int>> getAllDeviceIds()
        {
            var records = await _context.Devices.Select(r=>r.Id).ToListAsync();
            return records;
        }


        [HttpDelete("deleteDevice/{cihazId}")]
        public async Task<ActionResult> DeleteUser(int cihazId)
        {

            var deviceToDelete = await _context.Devices.FirstOrDefaultAsync(d => d.Id == cihazId);

            if (deviceToDelete is null)
            {
                return NotFound();
            }

            _context.Devices.Remove(deviceToDelete);
            await _context.SaveChangesAsync();

            return Ok();
        }


    }



}
