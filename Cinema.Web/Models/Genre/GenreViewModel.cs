using System.ComponentModel.DataAnnotations;

namespace Cinema.Web.Models
{
    public class GenreViewModel
    {
        public int Id { get; set; }

        [Required]
        [Display(Name = "Name: ")]
        public string Name { get; set; }
        
        [Display(Name = "Description: ")]
        public string Description { get; set; }
    }
}