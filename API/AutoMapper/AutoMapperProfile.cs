using AutoMapper;
using Sensor.API.Models;
using Sensor.API.Models.DTO;

namespace Sensor.API.AutoMapper
{
    public class AutoMapperProfile:Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<RecordDTO, SensorRecord>().ReverseMap();
            CreateMap<UserDTO, User>().ReverseMap();
            CreateMap<UserGetDTO, User>().ReverseMap();
            CreateMap<StatusDTO, DeviceStatus>().ReverseMap();

        }
    }
}
