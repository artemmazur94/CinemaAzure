using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web;
using Cinema.DataAccess;
using Cinema.Web.Helpers;

namespace Cinema.Web.Models
{
    public class ProfileViewModel
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(128)]
        [Display(Name = "Name: ")]
        public string Name { get; set; }

        [Required]
        [MaxLength(128)]
        [Display(Name = "Surname: ")]
        public string Surname { get; set; }

        [Display(Name = "Phone: ")]
        [DataType(DataType.PhoneNumber)]
        public string Phone { get; set; }

        [Display(Name = "Photo: ")]
        [MaxFileSize(5*1024*1024, ErrorMessage = "Maximum allowed file size is {0} bytes")]
        public HttpPostedFileBase Photo { get; set; }

        public byte[] ImageBytes { get; set; }
    }
}