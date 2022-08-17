﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Sensor.API.Data;

#nullable disable

namespace Sensor.API.Migrations
{
    [DbContext(typeof(AppDbContext))]
    partial class AppDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.7")
                .HasAnnotation("Relational:MaxIdentifierLength", 64);

            modelBuilder.Entity("Sensor.API.Models.SensorRecord", b =>
                {
                    /*b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");*/

                    b.Property<DateTime>("Date")
                        .HasColumnType("datetime(6)");

                    b.Property<Int16>("cihazId")
                        .HasColumnType("smallint");

                    b.Property<Byte>("pil")
                        .HasColumnType("tinyint");

                    b.Property<Byte>("sicaklik")
                        .HasColumnType("tinyint");

                    b.HasNoKey();

                    b.ToTable("Records");
                });

            modelBuilder.Entity("Sensor.API.Models.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("fullName")
                        .IsRequired()
                        .HasColumnType("varchar(30)");

                    b.Property<string>("password")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.Property<string>("username")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

             modelBuilder.Entity("Sensor.API.Models.Device", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("name")
                        .IsRequired()
                        .HasColumnType("longtext");

                    b.Property<DateTime>("createDate")
                        .HasColumnType("datetime(6)");

                    b.HasKey("Id");

                    b.ToTable("Devices");
                });

            modelBuilder.Entity("Sensor.API.Models.DeviceStatuses", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<int>("cihazId")
                        .HasColumnType("int");

                    b.Property<int>("isActive")
                        .HasColumnType("bool");

                    b.Property<DateTime>("createDate")
                        .HasColumnType("datetime(6)");

                    b.HasKey("Id");

                    b.ToTable("DeviceStatus");
                });

            modelBuilder.Entity("Sensor.API.Models.Alert", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("type")
                        .HasColumnType("text");

                    b.Property<string>("Message")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("Date")
                        .HasColumnType("datetime(6)");

                    b.HasKey("Id");

                    b.ToTable("Alerts");
                });
#pragma warning restore 612, 618
        }
    }
}
