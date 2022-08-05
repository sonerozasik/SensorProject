using System.ComponentModel.DataAnnotations.Schema;

namespace Sensor.API.Models
{

    public class SensorRecord
    {
        public int Id { get; set; }

        public int cihazId { get; set; }
        public float sicaklik { get; set; }
        public int pil { get; set; }

        public DateTime Date { get; set; }
    }
}
