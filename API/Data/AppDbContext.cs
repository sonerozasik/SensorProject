using Microsoft.EntityFrameworkCore;
using Sensor.API.Models;

namespace Sensor.API.Data
{
    public class AppDbContext:DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        

        public DbSet<SensorRecord> Records { get; set; }
        public DbSet<User> Users { get; set; }
    }
}
