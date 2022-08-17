using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Sensor.API.Migrations
{
    public partial class init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Records",
                columns: table => new
                {
                    cihazId = table.Column<Int16>(type: "smallint", nullable: false),
                    sicaklik = table.Column<Byte>(type: "tinyint", nullable: false),
                    pil = table.Column<Byte>(type: "tinyint", nullable: false),
                    Date = table.Column<DateTime>(type: "datetime(6)", nullable: false)
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    username = table.Column<string>(type: "varchar(24)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    password = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    fullName = table.Column<string>(type: "varchar(50)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "Alerts",
                columns: table => new
                {
                    deviceId = table.Column<Int16>(type: "smallint", nullable: false),
                    type = table.Column<string>(type: "varchar(15)", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    message = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Date = table.Column<DateTime>(type: "datetime(6)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Alerts", x => x.Date);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
               name: "Devices",
               columns: table => new
               {
                   Id = table.Column<Int16>(type: "smallint", nullable: false),
                   name = table.Column<string>(type: "varchar(30)", nullable: false)
                       .Annotation("MySql:CharSet", "utf8mb4"),
                   createDate = table.Column<DateTime>(type: "datetime(6)", nullable: false)
               },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Devices", x => x.Id);
                })
               .Annotation("MySql:CharSet", "utf8mb4");


            migrationBuilder.CreateTable(
               name: "DeviceStatuses",
               columns: table => new
               {
                   deviceId = table.Column<Int16>(type: "smallint", nullable: false),
                   isActive = table.Column<bool>(type: "tinyint(1)", nullable: false),
                   Date = table.Column<DateTime>(type: "datetime(6)", nullable: false)
               },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeviceStatuses", x => x.Date);
                })
               .Annotation("MySql:CharSet", "utf8mb4");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Records");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Alerts");

            migrationBuilder.DropTable(
                name: "Devices");

            migrationBuilder.DropTable(
                name: "DeviceStatuses");

        }
    }
}
