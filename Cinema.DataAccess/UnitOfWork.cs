using System;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly CinemaDatabaseEntities _context;

        public IAccountRepository AccountRepository { get; set; }

        public IGenreRepository GenreRepository { get; set; }

        public IMovieRepository MovieRepository { get; set; }

        public IPersonRepository PersonRepository { get; set; }

        public ISeanceRepository SeanceRepository { get; set; }

        public ISecurityTokenRepository SecurityTokenRepository { get; set; }

        public UnitOfWork(CinemaDatabaseEntities context, IAccountRepository accountRepository,
            IGenreRepository genreRepository, IMovieRepository movieRepository, IPersonRepository personRepository,
            ISeanceRepository seanceRepository, ISecurityTokenRepository securityTokenRepository)
        {
            _context = context;
            AccountRepository = accountRepository;
            GenreRepository = genreRepository;
            MovieRepository = movieRepository;
            PersonRepository = personRepository;
            SeanceRepository = seanceRepository;
            SecurityTokenRepository = securityTokenRepository;
        }

        public void Commit()
        {
            _context.SaveChanges();
        }

        private bool _disposed;

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _context.Dispose();
                }
            }
            _disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}