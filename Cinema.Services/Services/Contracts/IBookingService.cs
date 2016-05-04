using System;
using System.Collections.Generic;
using Cinema.DataAccess;

namespace Cinema.Services.Contracts
{
    public interface IBookingService : IDisposable
    {
        void Commit();

        List<Seance> GetActiveSeancesByMovieId(int movieId);

        Seance GetSeance(int id);

        List<Sector> GetSectorsByHallId(int hallId);

        bool IsTicketAbleToBook(int row, int place, int seanceId);

        void AddTicketPreOrder(TicketPreOrder ticketPreOrder);

        List<Ticket> GetSeanceTickets(int seanceId);

        List<TicketPreOrder> GetSeanceTicketPreOrdersOfOtherUsers(int seanceId, int profileId);

        List<TicketPreOrder> GetSeanceTicketPreOrdersForCurrentUser(int seanceId, int profileId);

        bool IsSeatBindedToOtherUser(int row, int place, int seanceId, int profileId);

        bool IsSeatBindedByCurrnetUser(int row, int place, int seanceId, int profileId);

        void RemoveTicketPreOrderForUser(int row, int place, int seeanceId, int profileId);

        void MarkTicketPreOrdersAsDeletedForUser(int seanceId, int profileId);

        void BookTickets(List<Ticket> tickets);

        void RemoveTicketPreOrdersForUser(int seanceId, int profileId);

        List<Ticket> GetTicketsForUser(int profileId);

        int GetSeatType(int hallId, int row, int place);

        List<Hall> GetAllHalls();

        bool IsAvailableSeanceTime(int hallId, DateTime dateTime, int movieLength);

        void AddSeance(Seance seance);

        List<int> GetSeatTypesForHall(int hallId);

        void SendTickets(List<Ticket> tickets, int languageId, string serverPath, Profile profile);

        decimal GetAvarageNumberOfBookedTickets();

        int GetNumberOfSeancesThisWeek();

        List<string> GetMoviesThisWeek();

        List<Seance> GetSeancesThisWeek();
    }
}