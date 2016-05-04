using System;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess
{
    public interface IUnitOfWork : IDisposable
    {
        IAccountRepository AccountRepository { get; }

        IGenreRepository GenreRepository { get; }

        IMovieRepository MovieRepository { get; }

        IPersonRepository PersonRepository { get; }

        ISeanceRepository SeanceRepository { get; }

        ISecurityTokenRepository SecurityTokenRepository { get; }
        
        void Commit();
    }
}