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
    public class SensorRecordsController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IMapper _mapper;

        public SensorRecordsController(AppDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/SensorRecords
        [HttpGet]
        [ActionName("GetAllRecords")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetRecords()
        {
            if (_context.Records == null)
            {
                return NotFound();
            }

            return await _context.Records.ToListAsync();
        }



        // Filtreleme
        // GET: api/SensorRecords/5
        [HttpGet("getRecords/{id}")]
        [ActionName("GetRecordsById")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetSensorRecord(int id)
        {

            var records = await _context.Records.Where(r => r.cihazId == id).ToListAsync();
            return Ok(records);

        }



        [HttpGet("getLastNRecord/{id}/{n}")]
        [ActionName("GetLastRecordById")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetLastRecordById(int id,int n)
        {

            var records = await _context.Records.Where(r => r.cihazId == id).OrderByDescending(y=>y.Date).Take(n).ToListAsync();

            if (records.Count > 100)
            {
                int skip = (records.Count / 100)+1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }

            return Ok(records);
        }



        [HttpGet("byDay/{id}/{lastXDays}")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetRecordsByDays(int id, int lastXDays)
        {
            if (lastXDays < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.Records.AsEnumerable().Where(r => (DateTime.Now - r.Date).Days < lastXDays && r.cihazId == id).OrderBy(y => y.Date).ToList();

            if (records.Count > 100)
            {
                int skip = (records.Count / 100)+1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }

            return Ok(records);
        }



        [HttpGet("byHour/{id}/{lastXHours}")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetRecordsByHours(int id, int lastXHours)
        {
            if (lastXHours < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.Records.AsEnumerable().Where(r => (DateTime.Now - r.Date).TotalHours < lastXHours && r.cihazId == id).OrderBy(y=> y.Date).ToList();
            
            if (records.Count > 100)
            {
                int skip = (records.Count / 100)+1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }
            return Ok(records);
        }



        [HttpGet("byMinute/{id}/{lastXMinutes}")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetRecordsByMinutes(int id, int lastXMinutes)
        {
            if (lastXMinutes < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.Records.AsEnumerable().Where(r => (DateTime.Now - r.Date).TotalMinutes < lastXMinutes && r.cihazId == id).OrderBy(y => y.Date).ToList(); ;
            
            if (records.Count > 100)
            {
                int skip = (records.Count / 100)+1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }
            
            return Ok(records);
        }



        [HttpGet("byMonth/{id}/{lastXMonths}")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetRecordsByMonths(int id, int lastXMonths)
        {
            if (lastXMonths < 0 || id <= 0)
            {
                return BadRequest();
            }

            
            var records = _context.Records.AsEnumerable().Where(r => (DateTime.Now.Month - r.Date.Month) < lastXMonths && r.cihazId == id).OrderBy(y => y.Date).ToList();

            if (records.Count > 100)
            {
                int skip = (records.Count / 100) + 1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }

            return Ok(records);
        }



        [HttpPut("between")]
        public async Task<IActionResult> GetRecordsBetween(DatesDTO datesDTO)
        {

            if (datesDTO.startDate >= datesDTO.endDate || datesDTO.cihazId<=0 )
            {
                return BadRequest();
            }


            var records = _context.Records.AsEnumerable().Where(r => r.Date>=datesDTO.startDate && r.Date<=datesDTO.endDate && r.cihazId == datesDTO.cihazId).OrderBy(y => y.Date).ToList();

            if (records.Count > 100)
            {
                int skip = (records.Count / 100) + 1;
                return Ok(records.Where((x, i) => i % skip == 0));
            }

            return Ok(records);
        }



        //todo doesn't work well
        /*
        [HttpGet("statusByMonth/{id}/{lastXMonths}")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetStatusByMonths(int id, int lastXMonths)
        {
            if (lastXMonths < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.Records.AsEnumerable().Where(r => (DateTime.Now.Month - r.Date.Month) < lastXMonths && r.cihazId == id).GroupBy(y=>y.Date.Day).ToList();

            return Ok(records);
        }
        */


        [HttpPost]
        public async Task<ActionResult<SensorRecord>> PostSensorRecord(RecordDTO sensorRecordDTO)
        {

            var newRecord = _mapper.Map<SensorRecord>(sensorRecordDTO);
            newRecord.Date = DateTime.Now;


            _context.Records.Add(newRecord);
            await _context.SaveChangesAsync();


            return Ok(newRecord);
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSensorRecord(int id)
        {
            if (_context.Records == null)
            {
                return NotFound();
            }

            var sensorRecord = await _context.Records.FindAsync(id);
            if (sensorRecord == null)
            {
                return NotFound();
            }

            _context.Records.Remove(sensorRecord);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        public void checkStatusEvery5Minute()
        {
            var status = isActive(2, DateTime.Now, DateTime.Now.AddMonths(-1));
        }

        private bool isActive(int cihazId,DateTime start,DateTime end)
        { 
            var qq= _context.Records.Any(n => n.Date >= start && n.Date < end);
            return qq;
        }

        public static bool IsStarted { get; set; }
        //public void start()
        //{
        //    var startTimeSpan = TimeSpan.Zero;
        //    var periodTimeSpan = TimeSpan.FromMinutes(5);

        //    var timer = new System.Threading.Timer((e) =>
        //    {
        //        checkStatusEvery5Minute();
        //    }, null, startTimeSpan, periodTimeSpan);

        //}

    }
}
