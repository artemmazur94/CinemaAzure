using System;
using Cinema.DataAccess;
using Cinema.Services.Contracts;

namespace Cinema.Services
{
    public class GenreService : IGenreService
    {
        private readonly IUnitOfWork _unitOfWork;

        public GenreService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public void Commit()
        {
            _unitOfWork.Commit();
        }

        public Genre GetGenre(int id)
        {
            return _unitOfWork.GenreRepository.Get(id);
        }

        public GenreLocalization GetGenreLocalization(int id, int languageId)
        {
            return _unitOfWork.GenreRepository.GetGenreLocalization(id, languageId);
        }

        public void AddGenreLocalization(GenreLocalization genreLocalization)
        {
            _unitOfWork.GenreRepository.AddGenreLocalization(genreLocalization);
        }

        public void RemoveGenre(Genre genre)
        {
            _unitOfWork.GenreRepository.Remove(genre);
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