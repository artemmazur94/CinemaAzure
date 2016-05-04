using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web;
using Cinema.Web.Helpers;

namespace Cinema.Web.Models
{
    public class MovieAddEditViewModel
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(128)]
        [Display(Name = "Name: ")]
        public string Name { get; set; }

        [Display(Name = "Description: ")]
        public string Description { get; set; }

        [Required]
        [Range(1, Int32.MaxValue)]
        [Display(Name = "Length: ")]
        public int Length { get; set; }
        
        [Display(Name = "Genre: ")]
        public int? GenreId { get; set; }

        [Display(Name = "Director: ")]
        public int? DirectorId { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Release date: ")]
        public DateTime ReleaseDate { get; set; }

        [Display(Name = "Actors list: ")]
        public List<int> ActorIds { get; set; }

        [Display(Name = "Trailer link: ")]
        public string VideoLink { get; set; }
        
        [MaxFileSize(1024 * 1024 * 5, ErrorMessage = "Maximum allowed file size is {0} bytes")]
        [Display(Name = "Poster: ")]
        public HttpPostedFileBase Poster { get; set; }
    }
}