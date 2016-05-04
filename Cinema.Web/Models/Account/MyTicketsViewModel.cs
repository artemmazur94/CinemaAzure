using System.Collections.Generic;

namespace Cinema.Web.Models
{
    public class MyTicketsViewModel
    {
        public List<TicketViewModel> UpcomingTickets { get; set; }

        public List<TicketViewModel> PastTickets { get; set; }
    }
}