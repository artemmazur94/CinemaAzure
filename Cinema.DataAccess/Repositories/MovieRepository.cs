using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class MovieRepository : GenericRepositrory<Movie>, IMovieRepository
    {
        private CinemaDatabaseEntities MovieContext => Context;

        public MovieRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

        public MovieLocalization GetMovieLocalization(int id, int languageId)
        {
            return MovieContext.MovieLocalizations.First(x => x.MovieId == id && x.LanguageId == languageId);
        }

        public List<MovieLocalization> GetMovieLocalizationsForPersons(List<int> movieIds, int languageId)
        {
            return MovieContext.MovieLocalizations.Where( x => 
                movieIds.Contains(x.MovieId) && 
                x.LanguageId == languageId).ToList();
        }

        public void DeletePhoto(Photo photo)
        {
            MovieContext.Photos.Remove(photo);
        }

        public Photo GetPhotoByMovieId(int movieId)
        {
            return MovieContext.Photos.FirstOrDefault(x => x.Movies.Any(z => z.Id == movieId));
        }

        public List<MovieLocalization> GetMovieLocalizations(List<int> movieIds, int languageId)
        {
            return MovieContext.MovieLocalizations.Where( x => 
                movieIds.Contains(x.MovieId) && 
                x.LanguageId == languageId).ToList();
        }

        public void AddMovieLocalization(MovieLocalization movieLocalization)
        {
            MovieContext.MovieLocalizations.Add(movieLocalization);
        }
    }
}