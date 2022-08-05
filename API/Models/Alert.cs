﻿namespace Sensor.API.Models
{
    public class Alert
    {
        public int Id { get; set; }
        public string Type { get; set; }  
        public string Message { get; set; }
        public DateTime Date { get; set; }
    }
}
