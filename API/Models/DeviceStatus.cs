namespace Sensor.API.Models
{
    public class DeviceStatus
    {
        public int Id { get; set; }

        public int cihazId { get; set; }
        
        public bool isActive { get; set; }

        public DateTime Date { get; set; }
    }
}
