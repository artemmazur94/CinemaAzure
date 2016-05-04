using System.ComponentModel.DataAnnotations;
using System.Web;
using Cinema.Web.Helpers;

namespace Cinema.Web.Models
{
    public class PersonAddEditViewModel
    {
        public int Id { get; set; } 

        [Required]
        [MaxLength(128)]
        [Display(Name = "Name: ")]
        public string Name { get; set; }

        [MaxFileSize(1024 * 1024 * 5, ErrorMessage = "Maximum allowed file size is {0} bytes")]
        [Display(Name = "Photo: ")]
        public HttpPostedFileBase Photo { get; set; }
    }
}