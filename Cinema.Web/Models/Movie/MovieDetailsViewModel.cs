using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Cinema.DataAccess;

namespace Cinema.Web.Models
{
    public class MovieDetailsViewModel
    {
        public int MovieId { get; set; }

        [Display(Name = "Name: ")]
        public string Name { get; set; }
        
        [Display(Name = "Description: ")]
        public string Description { get; set; }

        [Display(Name = "Length: ")]
        public int Length { get; set; }

        [Display(Name = "Release date: ")]
        public string ReleaseDate { get; set; }

        [Range(1, 5)]
        [Display(Name = "Rating: ")]
        public double? Rating { get; set; }
        
        [Display(Name = "Director: ")]
        public string DirectorName { get; set; }
        
        [Display(Name = "Actors list: ")]
        public List<string> ActorNames { get; set; }
        
        [Display(Name = "Genre: ")]
        public string GenreName { get; set; }
        
        public Photo Photo { get; set; }

        public string VideoLink { get; set; }
    }
}