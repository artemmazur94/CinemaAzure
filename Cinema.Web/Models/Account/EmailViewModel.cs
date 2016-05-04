using System.ComponentModel.DataAnnotations;

namespace Cinema.Web.Models
{
    public class EmailViewModel
    {
        [Required(AllowEmptyStrings = false)]
        [EmailAddress]
        [MaxLength(128)]
        [Display(Name = "Email address: ")]
        public string Email { get; set; }
    }
}