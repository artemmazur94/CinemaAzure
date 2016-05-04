using System;
using Cinema.DataAccess;
using SeatType = Cinema.Services.Helpers.SeatType;

namespace Cinema.Services.Models
{
    public class TicketPDFModel
    {
        public Guid Guid { get; set; }

        public string MovieName { get; set; }

        public DateTime Date { get; set; }

        public TimeSpan Time { get; set; }

        public string HallName { get; set; }

        public int Row { get; set; }

        public int Place { get; set; }

        public decimal Price { get; set; }

        public int SeatTypeId { get; set; }
    }
}