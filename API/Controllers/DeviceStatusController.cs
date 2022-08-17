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

    public class DeviceStatusController : ControllerBase
    {


        private readonly AppDbContext _context;
        private readonly IMapper _mapper;

        public DeviceStatusController(AppDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }



        [HttpGet("byMinute/{id}/{lastXMinutes}")]
        public async Task<IActionResult> GetStatusesByMinutes(int id, int lastXMinutes)
        {
            if (lastXMinutes < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.DeviceStatuses.AsEnumerable().Where(r => (DateTime.Now - r.Date).TotalMinutes < lastXMinutes && r.deviceId == id).OrderBy(y => y.Date).ToList(); ;

            if (records.Count > 100)
            {
                int skip = (records.Count / 100) + 1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }

            return Ok(records);
        }



        [HttpGet("byHour/{id}/{lastXHours}")]
        public async Task<IActionResult> GetStatusesByHours(int id, int lastXHours)
        {
            if (lastXHours < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.DeviceStatuses.AsEnumerable().Where(r => (DateTime.Now - r.Date).TotalHours < lastXHours && r.deviceId == id).OrderBy(y => y.Date).ToList();

            if (records.Count > 100)
            {
                int skip = (records.Count / 100) + 1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }
            return Ok(records);
        }



        [HttpGet("byDay/{id}/{lastXDays}")]
        public async Task<IActionResult> GetStatusesByDays(int id, int lastXDays)
        {
            if (lastXDays < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.DeviceStatuses.AsEnumerable().Where(r => (DateTime.Now - r.Date).Days < lastXDays && r.deviceId == id ).OrderBy(y => y.Date).ToList();

            if (records.Count > 100)
            {
                int skip = (records.Count / 100) + 1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }

            return Ok(records);
        }



        [HttpGet("byMonth/{id}/{lastXMonths}")]
        public async Task<IActionResult> GetStatusesByMonths(int id, int lastXMonths)
        {
            if (lastXMonths < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.DeviceStatuses.AsEnumerable().Where(r => (DateTime.Now.Month - r.Date.Month) < lastXMonths && r.deviceId == id).OrderBy(y => y.Date).ToList();

            if (records.Count > 100)
            {
                int skip = (records.Count / 100) + 1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }

            return Ok(records);
        }



        [HttpPut("between")]
        public async Task<IActionResult> GetStatusesBetween(DatesDTO datesDTO)
        {

            if (datesDTO.startDate >= datesDTO.endDate || datesDTO.cihazId <= 0)
            {
                return BadRequest();
            }


            var records = _context.DeviceStatuses.AsEnumerable().Where(r => r.Date >= datesDTO.startDate && r.Date <= datesDTO.endDate && r.deviceId == datesDTO.cihazId).OrderBy(y => y.Date).ToList();

            if (records.Count > 100)
            {
                int skip = (records.Count / 100) + 1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }

            return Ok(records);
        }

    }



   



}
