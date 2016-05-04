using System.ComponentModel.DataAnnotations;

namespace Cinema.Web.Models
{
    public class LoginViewModel
    {
        [Required(AllowEmptyStrings = false)]
        [MaxLength(128)]
        [Display(Name = "Username: ")]
        public string Username { get; set; }

        [Required(AllowEmptyStrings = false)]
        [DataType(DataType.Password)]
        [Display(Name = "Password: ")]
        public string Password { get; set; }

        [Display(Name = "Remember me: ")]
        public bool RememberMe { get; set; }

        public DataAccess.Account ToAccount()
        {
            return new DataAccess.Account()
            {
                Login = Username,
                Password = Password
            };
        }
    }
}