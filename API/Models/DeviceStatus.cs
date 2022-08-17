using System.ComponentModel.DataAnnotations;

namespace Sensor.API.Models
{
    public class DeviceStatus
    {
        public int deviceId { get; set; }
        
        public bool isActive { get; set; }

        [Key]
        public DateTime Date { get; set; }
    }
}
