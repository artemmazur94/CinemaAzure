using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Cinema.DataAccess;

namespace Cinema.Web.Models
{
    public class MoviesListViewModel
    {
        public int MovieId { get; set; }

        [Required]
        [Display(Name = "Name: ")]
        [MaxLength(128)]
        public string Name { get; set; }

        [Required]
        [Range(1, Int32.MaxValue)]
        [Display(Name = "Length: ")]
        public int Length { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Release date: ")]
        public string ReleaseDate { get; set; }

        [Range(1, 5)]
        public double? Rating { get; set; }
        
        [Display(Name = "Director: ")]
        public string DirectorName { get; set; }
        
        [Display(Name = "Actors list: ")]
        public List<string> ActorNames { get; set; } 
        
        [Display(Name = "Genre: ")]
        public string GenreName { get; set; }
        
        public Photo Photo { get; set; }
    }
}