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

    public class AlertsController : ControllerBase
    {


        private readonly AppDbContext _context;
        private readonly IMapper _mapper;

        public AlertsController(AppDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }


        [HttpGet("getAllAlerts")]
        public async Task<IActionResult> GetAllUsers()
        {
            var records = await _context.Alerts.ToListAsync();
            return Ok(records);
        }



        [HttpGet("getLastXAlert/{Count}")]
        public async Task<IActionResult> getLastXAlert(int Count)
        {
            if (_context.Alerts.Count() >= Count)
            {
                var records = await _context.Alerts.OrderByDescending(x => x.date).Take(Count).ToListAsync();
                return Ok(records);
            }
            else
            {
                var records = await _context.Alerts.OrderByDescending(x => x.date).ToListAsync();
                return Ok(records);
            }
        }


        [HttpGet("getLastXAlertById/{Count}/{deviceId}")]
        public async Task<IActionResult> getLastXAlertById(int Count,int deviceId)
        {
            if (_context.Alerts.Where(x => x.deviceId == deviceId).Count() >= Count)
            {
                var records = await _context.Alerts.Where(x=>x.deviceId==deviceId).OrderByDescending(x => x.date).Take(Count).ToListAsync();
                return Ok(records);
            }
            else
            {
                var records = await _context.Alerts.Where(x => x.deviceId == deviceId).OrderByDescending(x => x.date).ToListAsync();
                return Ok(records);
            }
        }


        [HttpGet("getAllAlertsById/{deviceId}")]
        public async Task<IActionResult> getAllAlertsById(int deviceId)
        {

                var records = await _context.Alerts.Where(x => x.deviceId == deviceId).OrderByDescending(x => x.date).ToListAsync();
                return Ok(records);   
            
        }
    }



}
