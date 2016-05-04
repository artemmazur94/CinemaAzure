using System;
using System.Collections.Generic;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface IGenreRepository : IDisposable, IRepository<Genre>
    {
        GenreLocalization GetGenreLocalization(int genreId, int languageId);

        List<GenreLocalization> GetAllGenreLocalizations(int languageId);

        List<GenreLocalization> GetGenresForMovies(List<int> genreIds, int languageId);

        void AddGenreLocalization(GenreLocalization genreLocalization);
    }
}