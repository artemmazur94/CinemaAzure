using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using Cinema.DataAccess;
using Cinema.Services.Contracts;

namespace Cinema.Services
{
    public class MovieService : IMovieService
    {
        private readonly IUnitOfWork _unitOfWork;

        private readonly string KEY_PHOTO_DIRECTORY = "PhotoDirectory";

        public MovieService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public void Commit()
        {
            _unitOfWork.Commit();
        }

        public List<Movie> GetAllMovies()
        {
            return _unitOfWork.MovieRepository.Find(x => x.IsDeleted == false).ToList();
        }

        public Movie GetMovie(int id)
        {
            return _unitOfWork.MovieRepository.Find(x => x.Id == id && x.IsDeleted == false).FirstOrDefault();
        }

        public MovieLocalization GetMovieLocalization(int id, int languageId)
        {
            return _unitOfWork.MovieRepository.GetMovieLocalization(id, languageId);
        }

        public string GetGenreLocalizationName(int genreId, int languageId)
        {
            return _unitOfWork.GenreRepository.GetGenreLocalization(genreId, languageId).Name;
        }

        public List<string> GetActorLocalizations(ICollection<Person> actors, int languageId)
        {
            return _unitOfWork.PersonRepository.GetActorLocalizations(actors, languageId);
        }

        public List<PersonLocalization> GetActorLocalizationsForMovies(List<int> personIds, int languageId)
        {
            return _unitOfWork.PersonRepository.GetActorLocalizationsForMovies(personIds, languageId);
        }

        public string GetDirectorLocalization(int directorId, int languageId)
        {
            return _unitOfWork.PersonRepository.GetPersonLocalization(directorId, languageId).Name;
        }

        public List<GenreLocalization> GetAllGenreLocalizations(int languageId)
        {
            return _unitOfWork.GenreRepository.GetAllGenreLocalizations(languageId);
        }

        public List<PersonLocalization> GetAllPersonLocalizations(int languageId)
        {
            return _unitOfWork.PersonRepository.GetAllPersonLocalizations(languageId);
        }

        public Photo SetPhotoToDirectory(HttpPostedFileBase poster, string serverPath)
        {
            string extention = System.IO.Path.GetExtension(poster.FileName);
            var guid = Guid.NewGuid();
            string path = ConfigurationManager.AppSettings[KEY_PHOTO_DIRECTORY] + guid + extention;
            poster.SaveAs(serverPath + path);
            var photo = new Photo()
            {
                Filename = poster.FileName,
                GUID = guid,
                Path = path
            };
            return photo;
        }

        public List<Person> GetSelectedActors(List<int> actorIds)
        {
            return _unitOfWork.PersonRepository.GetSelectedActors(actorIds);
        }

        public void AddMovieLocalization(MovieLocalization movieLocalization)
        {
            _unitOfWork.MovieRepository.AddMovieLocalization(movieLocalization);
        }

        public List<int> GetActorIdsForMovie(int movieId)
        {
            return _unitOfWork.PersonRepository.GetActorIdsForMovie(movieId);
        }

        public void RemoveMovie(int id, int profileId)
        {
            Movie movie = _unitOfWork.MovieRepository.Get(id);
            movie.RemoveExecutorId = profileId;
            movie.IsDeleted = true;
        }

        public void DeletePreviousPhotoFromDirectory(Photo photo, string serverPath)
        {
            if (System.IO.File.Exists(serverPath + photo.Path))
            {
                System.IO.File.Delete(serverPath + photo.Path);
            }
            _unitOfWork.MovieRepository.DeletePhoto(photo);
        }

        public List<GenreLocalization> GetGenreLocalizationsForMovies(List<int> genreIds, int languageId)
        {
            return _unitOfWork.GenreRepository.GetGenresForMovies(genreIds, languageId);
        }

        public List<MovieLocalization> GetMovieLocalizations(List<int> movieIds, int languageId)
        {
            return _unitOfWork.MovieRepository.GetMovieLocalizations(movieIds, languageId);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                _unitOfWork.Dispose();
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}