using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using Cinema.DataAccess.Helpers;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class SeanceRepository : GenericRepositrory<Seance>, ISeanceRepository
    {
        private CinemaDatabaseEntities SeanceContext => Context;

        public SeanceRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

        public List<Sector> GetSectorsByHallId(int hallId)
        {
            return SeanceContext.Sectors.Where(x => x.HallId == hallId).ToList();
        }

        public bool IsExistTicketPreOrder(int row, int place, int seanceId)
        {
            return SeanceContext.TicketPreOrders.FirstOrDefault(x =>
                x.Place == place &&
                x.Row == row &&
                x.SeanceId == seanceId) != null;
        }

        public bool IsExistTicket(int row, int place, int seanceId)
        {
            return SeanceContext.Tickets.FirstOrDefault(x =>
                x.Place == place &&
                x.Row == row &&
                x.SeanceId == seanceId) != null;
        }

        public void AddTicketPreOrder(TicketPreOrder ticketPreOrder)
        {
            SeanceContext.TicketPreOrders.Add(ticketPreOrder);
        }

        public List<Ticket> GetSeanceTickets(int seanceId)
        {
            return SeanceContext.Tickets.Where(x => x.SeanceId == seanceId).ToList();
        }

        public List<TicketPreOrder> GetSeanceTicketPreOrdersOfOtherUsers(int seanceId, int profileId)
        {
            return SeanceContext.TicketPreOrders.Where(x =>
                x.SeanceId == seanceId &&
                x.ProfileId != profileId).ToList();
        }

        public List<TicketPreOrder> GetSeanceTicketPreOrdersForUser(int seanceId, int profileId)
        {
            return SeanceContext.TicketPreOrders.Where(x =>
                x.SeanceId == seanceId &&
                x.ProfileId == profileId).ToList();
        }

        public bool IsSeatBindedToOtherUser(int row, int place, int seanceId, int profileId)
        {
            return SeanceContext.TicketPreOrders.FirstOrDefault(x =>
                x.SeanceId == seanceId &&
                x.Place == place &&
                x.Row == row &&
                x.ProfileId != profileId) != null;
        }

        public bool IsSeatBindedByCurrnetUser(int row, int place, int seanceId, int profileId)
        {
            return SeanceContext.TicketPreOrders.FirstOrDefault(x =>
                x.ProfileId == profileId &&
                x.SeanceId == seanceId &&
                x.Row == row &&
                x.Place == place) != null;
        }

        public TicketPreOrder GetTicketPreOrderBySeanceData(int row, int place, int seanceId, int profileId)
        {
            return SeanceContext.TicketPreOrders.FirstOrDefault(x =>
                x.Row == row &&
                x.Place == place &&
                x.SeanceId == seanceId &&
                x.ProfileId == profileId);
        }

        public void RemoveTicketPreOrder(TicketPreOrder ticketPreOrder)
        {
            SeanceContext.TicketPreOrders.Remove(ticketPreOrder);
        }

        public void MarkSeanceTicketPreOrdersAsDeletedForUser(int seanceId, int profileId)
        {
            List<TicketPreOrder> ticketPreOrders = GetSeanceTicketPreOrdersForUser(seanceId, profileId);
            SeanceContext.TicketPreOrders.RemoveRange(ticketPreOrders);
            var ticketPreOrdersDeleted = new List<TicketPreOrdersDeleted>();
            ticketPreOrders.ForEach(x => ticketPreOrdersDeleted.Add(new TicketPreOrdersDeleted()
            {
                ProfileId = profileId,
                DateTime = DateTime.UtcNow,
                Place = x.Place,
                Row = x.Row,
                SeanceId = x.SeanceId
            }));
            SeanceContext.TicketPreOrdersDeleted.AddRange(ticketPreOrdersDeleted);
        }

        public void AddTickets(List<Ticket> tickets)
        {
            SeanceContext.Tickets.AddRange(tickets);
        }

        public List<Ticket> GetTicketsForUser(int profileId)
        {
            return SeanceContext.Tickets.Where(x => x.ProfileId == profileId).Include(x => x.Seance).ToList();
        }

        public int GetSeatType(int hallId, int row, int place)
        {
            return SeanceContext.Sectors.FirstOrDefault(x =>
                x.HallId == hallId &&
                x.FromRow <= row && x.ToRow >= row &&
                x.FromPlace <= place && x.ToPlace >= place).SeatTypeId;
        }

        public List<Hall> GetAllHalls()
        {
            return SeanceContext.Halls.ToList();
        }

        public bool IsAvailableSeanceTime(int hallId, DateTime dateTime, int movieLength)
        {
            DateTimeRange checkedDateTimeRange = new DateTimeRange()
            {
                Start = dateTime,
                End = dateTime.AddMinutes(movieLength)
            };
            List<DateTimeRange> seanceDateTimeRanges =
                (from seance in SeanceContext.Seances.ToList().Where(x => x.DateTime.Date == dateTime.Date)
                 select new DateTimeRange()
                 {
                     Start = seance.DateTime,
                     End = seance.DateTime.AddMinutes(seance.Movie.Length)
                 }).ToList();
            return seanceDateTimeRanges.All(x => x.Intersects(checkedDateTimeRange) == false);
        }

        public List<int> GetSeatTypesForHall(int hallId)
        {
            return (from sector in SeanceContext.Sectors.Where(x => x.HallId == hallId)
                    select sector.SeatTypeId).Distinct().ToList();
        }

        public decimal GetPriceBySeatTypeId(int seatTypeId, int seanceId)
        {
            return
                SeanceContext.SectorTypePrices.FirstOrDefault(x => x.SeanceId == seanceId && x.SeatTypeId == seatTypeId)
                    .Price;
        }

        public decimal GetAvarageNumberOfBookedTickets()
        {
            return SeanceContext.AverageNumberOfTicketsOnSeance().FirstOrDefault().Value;
        }

        public int GetNumberOfSeancesThisWeek()
        {
            return SeanceContext.NumberOfSeancesThisWeek().FirstOrDefault().Value;
        }

        public List<string> GetMoviesThisWeek()
        {
            return SeanceContext.MoviesThisWeek().ToList();
        }

        public List<Seance> GetSeancesThisWeek()
        {
            var dateFrom = DateTime.UtcNow;
            var dateTo = dateFrom.AddDays(7);
            return SeanceContext.Seances.Where(x => x.DateTime >= dateFrom && x.DateTime <= dateTo).ToList();
        }
    }
}