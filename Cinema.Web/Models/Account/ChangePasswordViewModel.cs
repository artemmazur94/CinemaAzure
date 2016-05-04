using System.ComponentModel.DataAnnotations;

namespace Cinema.Web.Models
{
    public class ChangePasswordViewModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Old password: ")]
        public string OldPassword { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [MinLength(8)]
        [MaxLength(128)]
        [Display(Name = "New password: ")]
        public string NewPassword { get; set; }

        [Compare("NewPassword")]
        [DataType(DataType.Password)]
        [Display(Name = "Confirm new password: ")]
        public string NewPasswordConfirm { get; set; }
    }
}