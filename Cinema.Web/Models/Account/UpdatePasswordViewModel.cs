using System;
using System.ComponentModel.DataAnnotations;

namespace Cinema.Web.Models
{
    public class UpdatePasswordViewModel
    {
        [Required]
        [Display(Name = "Username: ")]
        public string Username { get; set; }

        [Required]
        [Display(Name = "Password: ")]
        [DataType(DataType.Password)]
        [MinLength(8)]
        [MaxLength(129)]
        public string Password { get; set; }
        
        [Display(Name = "Confirm password: ")]
        [Compare("Password")]
        [DataType(DataType.Password)]
        public string ConfirmPassword { get; set; }
        
        public Guid Token { get; set; }
    }
}