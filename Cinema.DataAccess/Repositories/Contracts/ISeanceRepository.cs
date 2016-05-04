using System;
using System.Collections.Generic;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface ISeanceRepository : IDisposable, IRepository<Seance>
    {
        List<Sector> GetSectorsByHallId(int hallId);

        bool IsExistTicketPreOrder(int row, int place, int seanceId);

        bool IsExistTicket(int row, int place, int seanceId);

        void AddTicketPreOrder(TicketPreOrder ticketPreOrder);

        List<Ticket> GetSeanceTickets(int seanceId);

        List<TicketPreOrder> GetSeanceTicketPreOrdersOfOtherUsers(int seanceId, int profileId);

        List<TicketPreOrder> GetSeanceTicketPreOrdersForUser(int seanceId, int profileId);

        bool IsSeatBindedToOtherUser(int row, int place, int seanceId, int profileId);

        bool IsSeatBindedByCurrnetUser(int row, int place, int seanceId, int profileId);

        TicketPreOrder GetTicketPreOrderBySeanceData(int row, int place, int seanceId, int profileId);

        void RemoveTicketPreOrder(TicketPreOrder ticketPreOrder);

        void MarkSeanceTicketPreOrdersAsDeletedForUser(int seanceId, int profileId);

        void AddTickets(List<Ticket> tickets);

        List<Ticket> GetTicketsForUser(int profileId);

        int GetSeatType(int hallId, int row, int place);

        List<Hall> GetAllHalls();

        bool IsAvailableSeanceTime(int hallId, DateTime dateTime, int movieLength);

        List<int> GetSeatTypesForHall(int hallId);

        decimal GetPriceBySeatTypeId(int seatTypeId, int seanceId);

        decimal GetAvarageNumberOfBookedTickets();

        int GetNumberOfSeancesThisWeek();

        List<string> GetMoviesThisWeek();

        List<Seance> GetSeancesThisWeek();
    }
}