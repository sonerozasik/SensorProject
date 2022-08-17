using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sensor.API.Models
{
    public class SensorRecord
    {
        public Int16 cihazId { get; set; }
        public Byte sicaklik { get; set; }
        public Byte pil { get; set; }

        [Key]
        public DateTime Date { get; set; }
    }
}
