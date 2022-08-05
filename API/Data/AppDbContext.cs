using Microsoft.EntityFrameworkCore;
using Sensor.API.Models;

namespace Sensor.API.Data
{
    public class AppDbContext:DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
            Database.EnsureCreated();
        }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SensorRecord>()
                .HasIndex(b => b.cihazId)
                //.IsUnique()
                .HasFilter(null);
        }

        public DbSet<SensorRecord> Records { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<DeviceStatus> DeviceStatuses { get; set; }
        public DbSet<Device> Devices { get; set; }
        public DbSet<Alert> Alerts { get; set; }


    }
}
