using System;
using Cinema.DataAccess;

namespace Cinema.Services.Contracts
{
    public interface IGenreService : IDisposable
    {
        void Commit();

        Genre GetGenre(int id);

        GenreLocalization GetGenreLocalization(int id, int languageId);

        void AddGenreLocalization(GenreLocalization genreLocalization);

        void RemoveGenre(Genre genre);
    }
}