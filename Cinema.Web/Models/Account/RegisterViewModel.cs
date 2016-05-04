using System.ComponentModel.DataAnnotations;

namespace Cinema.Web.Models
{
    public class RegisterViewModel
    {
        [Required]
        [MinLength(4)]
        [MaxLength(128)]
        [Display(Name = "Username: ")]
        public string Username { get; set; }

        [Required]
        [EmailAddress]
        [MaxLength(128)]
        [Display(Name = "Email: ")]
        public string Email { get; set; }

        [Required]
        [MaxLength(128)]
        [Display(Name = "Name: ")]
        public string Name { get; set; }

        [Required]
        [MaxLength(128)]
        [Display(Name = "Surname: ")]
        public string Surname { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [MinLength(8)]
        [MaxLength(128)]
        [Display(Name = "Password: ")]
        public string Password { get; set; }

        [Compare("Password")]
        [DataType(DataType.Password)]
        [Display(Name = "Confirm password: ")]
        public string PasswordConfirm { get; set; }
    }
}