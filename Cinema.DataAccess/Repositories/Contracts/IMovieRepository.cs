using System;
using System.Collections.Generic;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface IMovieRepository : IDisposable, IRepository<Movie>
    {
        MovieLocalization GetMovieLocalization(int id, int languageId);

        List<MovieLocalization> GetMovieLocalizationsForPersons(List<int> movieIds, int languageId);

        void AddMovieLocalization(MovieLocalization movieLocalization);

        void DeletePhoto(Photo photo);

        Photo GetPhotoByMovieId(int movieId);

        List<MovieLocalization> GetMovieLocalizations(List<int> movieIds, int languageId);
    }
}