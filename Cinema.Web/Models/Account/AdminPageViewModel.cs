using System.Collections.Generic;

namespace Cinema.Web.Models
{
    public class AdminPageViewModel
    {
        public decimal AvarageNumberOfBookedTickets { get; set; }

        public int NumberOfSeancesThisWeek { get; set; }

        public List<string> MoviesThisWeek { get; set; }

        public List<SeanceViewModel> SeancesThisWeek { get; set; }
    }
}