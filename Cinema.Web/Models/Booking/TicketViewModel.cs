using System;
using System.ComponentModel.DataAnnotations;

namespace Cinema.Web.Models
{
    public class TicketViewModel
    {
        public int Id { get; set; }

        [Display(Name = "Movie name: ")]
        public string MovieName { get; set; }

        [Display(Name = "Hall name: ")]
        public string HallName { get; set; }

        [Display(Name = "Date: ")]
        public DateTime Date { get; set; }

        [Display(Name = "Time: ")]
        public TimeSpan Time { get; set; }

        [Display(Name = "Price: ")]
        public decimal Price { get; set; }
        
        public HallSeat Seat { get; set; }
    }
}