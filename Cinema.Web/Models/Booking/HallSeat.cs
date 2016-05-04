using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using Cinema.DataAccess;

namespace Cinema.Web.Models
{
    public class HallSeat
    {
        [Display(Name = "Row: ")]
        public int Row { get; set; }
        
        [Display(Name = "Place: ")]
        public int Place { get; set; }

        [Display(Name = "Seat type: ")]
        public int Type { get; set; }

        public static List<HallSeat> GetAllSeats(List<Ticket> seanceTickets, List<TicketPreOrder> seanceTicketPreOrders)
        {
            List<HallSeat> seats = (from seanceTicket in seanceTickets
                select new HallSeat()
                {
                    Row = seanceTicket.Row,
                    Place = seanceTicket.Place 
                }).ToList();
            seats.AddRange((from seanceTicketPreOrder in seanceTicketPreOrders
                select new HallSeat()
                {
                    Row = seanceTicketPreOrder.Row,
                    Place = seanceTicketPreOrder.Place
                }).Distinct());
            return seats;
        }

        public static List<HallSeat> GetAllSeats(List<TicketPreOrder> seanceTicketPreOrders)
        {
            return (from seanceTicketPreOrder in seanceTicketPreOrders
                select new HallSeat()
                {
                    Row = seanceTicketPreOrder.Row,
                    Place = seanceTicketPreOrder.Place
                }).ToList();
        }

        public static void SetSeatTypes(List<HallSeat> selectedSeats, List<Sector> sectors)
        {
            selectedSeats.ForEach( x =>
                    x.Type =
                        sectors.First( z =>
                                x.Row >= z.FromRow && 
                                x.Row <= z.ToRow && 
                                x.Place >= z.FromPlace && 
                                x.Place <= z.ToPlace)
                            .SeatType.Id);
        }
    }
}