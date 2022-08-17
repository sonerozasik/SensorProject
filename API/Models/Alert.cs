using System.ComponentModel.DataAnnotations;

namespace Sensor.API.Models
{
    public class Alert
    {
        public Int16 deviceId { get; set; }
        public string type { get; set; }  
        public string message { get; set; }

        [Key]
        public DateTime date { get; set; }
    }
}
