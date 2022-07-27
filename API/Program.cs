using Microsoft.EntityFrameworkCore;
using Sensor.API.AutoMapper;
using Sensor.API.Data;

var builder = WebApplication.CreateBuilder(args);
var connectionString = builder.Configuration.GetConnectionString("Url");


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddAutoMapper(typeof(AutoMapperProfile));

builder.Services.AddCors(c =>
{
    c.AddPolicy("All", p => p.AllowAnyHeader().AllowAnyOrigin().AllowAnyMethod());
});

builder.Services.AddDbContext<AppDbContext>(ops =>
{
    ops.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString));
});


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();
app.UseCors("All");
app.UseAuthorization();
app.MapControllers();
app.Run();
