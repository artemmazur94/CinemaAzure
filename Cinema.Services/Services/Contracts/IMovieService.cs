using System;
using System.Collections.Generic;
using System.Web;
using Cinema.DataAccess;

namespace Cinema.Services.Contracts
{
    public interface IMovieService : IDisposable
    {
        void Commit();

        List<Movie> GetAllMovies();

        Movie GetMovie(int id);

        MovieLocalization GetMovieLocalization(int id, int languageId);

        string GetGenreLocalizationName(int genreId, int languageId);

        List<string> GetActorLocalizations(ICollection<Person> actors, int languageId);

        List<PersonLocalization> GetActorLocalizationsForMovies(List<int> personIds, int labguageId);

        string GetDirectorLocalization(int directorId, int languageId);

        List<GenreLocalization> GetAllGenreLocalizations(int languageId);

        List<PersonLocalization> GetAllPersonLocalizations(int languageId);

        Photo SetPhotoToDirectory(HttpPostedFileBase poster, string serverPath);

        List<Person> GetSelectedActors(List<int> actorIds);

        void AddMovieLocalization(MovieLocalization movieLocalization);

        List<int> GetActorIdsForMovie(int movieId);

        void RemoveMovie(int id, int profileId);

        void DeletePreviousPhotoFromDirectory(Photo photo, string serverPath);

        List<GenreLocalization> GetGenreLocalizationsForMovies(List<int> genreIds, int languageId);

        List<MovieLocalization> GetMovieLocalizations(List<int> movieIds, int currnetCulture);
    }
}