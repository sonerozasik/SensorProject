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

            return Ok(records);
        }



        [HttpGet("byDate/{id}/{lastXDays}")]
        public async Task<ActionResult<IEnumerable<SensorRecord>>> GetRecordsByDate(int id, int lastXDays)
        {
            if (lastXDays < 0 || id <= 0)
            {
                return BadRequest();
            }


            var records = _context.Records.AsEnumerable().Where(r => (DateTime.Now - r.Date).Days < lastXDays && r.cihazId == id);
            return Ok(records);
        }



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


    }
}
