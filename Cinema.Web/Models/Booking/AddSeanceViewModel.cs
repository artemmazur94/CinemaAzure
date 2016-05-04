using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Cinema.DataAccess;

namespace Cinema.Web.Models
{
    public class AddSeanceViewModel
    {
        [Required]
        public int MovieId { get; set; }

        [Required]
        [Display(Name = "Movie name: ")]
        public string MovieName { get; set; }
        
        [Required]
        [Display(Name = "Date: ")]
        [DataType(DataType.Date)]
        public DateTime Date { get; set; }

        [Required]
        [Display(Name = "Time: ")]
        public TimeSpan Time { get; set; }

        [Required]
        [Display(Name = "Hall: ")]
        public int HallId { get; set; }

        [Required]
        public List<SectorTypePrice> SeatTypePrices { get; set; } 
    }
}