using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sensor.API.Data;
using Sensor.API.Models;
using Sensor.API.Models.DTO;
using System.Security.Cryptography;
using System.Text;

namespace Sensor.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {

        //todo Giriş yapmış kullanıcının şifresini doğrulama +
        //todo Tüm kullanıcıları alan metotu ekle +
        //todo DeleteUser Metotu ekle +
        //todo ForgotPassword metotu eklenebilir 


        private readonly AppDbContext _context;
        private readonly IMapper _mapper;

        public UsersController(AppDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }


        [HttpGet("getAllUsers")]
        public async Task<IEnumerable<User>> GetAllUsers()
        {
            var records = await _context.Users.ToListAsync();
            return records;
        }


        [HttpGet("{username}")]
        public async Task<ActionResult> GetUserByUsername(string username = null)
        {


            var user = await _context.Users.FirstOrDefaultAsync(u => u.username == username);

            if (user is null)
            {
                return NotFound();
            }


            if (string.IsNullOrEmpty(user.username))
            {
                return BadRequest();
            }

            return Ok(user);
        }


        [HttpPut("changeUsername/{newUsername}/{oldUsername}")]
        public async Task<ActionResult> UpdateUsername(string newUsername, string oldUsername)
        {
            var currentUser = await _context.Users.FirstOrDefaultAsync(u => u.username == oldUsername);


            if (currentUser is null)
            {
                return NotFound();
            }

            var userExist = await _context.Users.FirstOrDefaultAsync(u => u.username == newUsername) == null ? false : true;

            if (userExist)
            {
                return BadRequest();
            }


            currentUser.username = newUsername;
            _context.Update(currentUser);
            await _context.SaveChangesAsync();

            return Ok(currentUser);
        }

        [HttpPut("changePassword/{newPassword}/{oldPassword}/{username}")]
        public async Task<ActionResult> UpdatePassword(string newPassword, string oldPassword, string username)
        {

            var user = await _context.Users.FirstOrDefaultAsync(u => u.username == username);
            //userDTO.password = 
            //var user = _mapper.Map<User>(userDTO);

            if (user is null)
            {
                return NotFound();
            }


            if (user.password != HashPassword(oldPassword))
            {
                return BadRequest();
            }

            user.password = HashPassword(newPassword);
            _context.Users.Update(user);
            await _context.SaveChangesAsync();

            return Ok(user);
        }


        [HttpPost("register")]
        public async Task<ActionResult> CreateUser(UserDTO userDTO)
        {
            if (userDTO.username.Length > 24)
            {
                return BadRequest("Username is too long!");
            }

            if (userDTO.password.Length > 36)
            {
                return BadRequest("Password is too long!");

            }

            if (UserExists(userDTO))
            {
                return BadRequest("User is already exists!");
            }

            userDTO.password = HashPassword(userDTO.password);
            var record = _mapper.Map<User>(userDTO);
            await _context.Users.AddAsync(record);
            await _context.SaveChangesAsync();

            return Ok();
        }



        [HttpPost("login")]
        public bool Login(PostUserDTO user)
        {
            var userDTO = new UserDTO()
            {
                password = user.password,
                username = user.username
            };

            return CheckPassword(userDTO);
        }



        [HttpPost("{username}/checkPassword")]
        public bool CheckPassword(UserDTO userDTO)
        {
            //todo Tüm metotu değişen route parametrelerine göre düzenle

            var tryPassword = HashPassword(userDTO.password);
            var result = _context.Users.FirstOrDefault(u => u.username == userDTO.username && u.password == tryPassword) == null ? false : true;

            return result;
        }



        [HttpDelete("deleteUser/{username}")]
        public async Task<ActionResult> DeleteUser(string username, UserDTO userDTO)
        {
            if (username != userDTO.username)
            {
                return BadRequest();
            }

            var userToDelete = await _context.Users.FirstOrDefaultAsync(u => u.username == username);

            if (userToDelete is null)
            {
                return NotFound();
            }

            _context.Users.Remove(userToDelete);
            await _context.SaveChangesAsync();

            return Ok();
        }


        [HttpGet("find/{username}")]
        public IEnumerable<UserGetDTO> Find(string username = "")
        {
            var users = _context.Users.Where(u => u.username.Contains(username));
            var records = _mapper.Map<IEnumerable<UserGetDTO>>(users);

            return records;
        }


        private bool UserExists(UserDTO userDTO)
        {
            var userResult = _context.Users.FirstOrDefault(u => u.username == userDTO.username);
            return userResult == null ? false : true;
        }

        private string HashPassword(string password = null)
        {

            if (password is null)
            {
                return null;
            }

            SHA256 hash = SHA256.Create();
            var passwordBytes = Encoding.Default.GetBytes(password);

            var hashedPassword = hash.ComputeHash(passwordBytes);
            password = Convert.ToHexString(hashedPassword);

            return password;
        }

    }
}
