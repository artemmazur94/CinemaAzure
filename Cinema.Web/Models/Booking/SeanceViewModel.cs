using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Cinema.DataAccess;

namespace Cinema.Web.Models
{
    public class SeanceViewModel
    {
        public int Id { get; set; }
        
        [Display(Name = "Date: ")]
        public DateTime Date { get; set; }
        
        [Display(Name = "Time: ")]
        public TimeSpan Time { get; set; }
        
        [Display(Name = "Prices: ")]
        public List<SectorTypePrice> Prices { get; set; }
        
        [Display(Name = "Hall name: ")]
        public string HallName { get; set; }

        [Display(Name = "Movie name: ")]
        public string MovieName { get; set; }

        public int MovieId { get; set; }

        public Dictionary<int, Dictionary<int ,int>> HallPlan { get; set; }

        public List<HallSeat> Seats { get; set; } 

        public List<HallSeat> SelectedSeats { get; set; } 
    }
}