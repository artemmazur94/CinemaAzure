using System;
using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess;
using Cinema.Services.Contracts;

namespace Cinema.Services
{
    public class PersonService : IPersonService
    {
        private readonly IUnitOfWork _unitOfWork;

        public PersonService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public void Commit()
        {
            _unitOfWork.Commit();
        }

        public List<Person> GetAllPersons()
        {
            return _unitOfWork.PersonRepository.GetAll().ToList();
        }

        public Person GetPerson(int id)
        {
            return _unitOfWork.PersonRepository.Get(id);
        }

        public List<PersonLocalization> GetAllPersonLocalizations(int languageId)
        {
            return _unitOfWork.PersonRepository.GetAllPersonLocalizations(languageId);
        }

        public List<MovieLocalization> GetMovieLocalizations(List<int> movieIds, int languageId)
        {
            return _unitOfWork.MovieRepository.GetMovieLocalizationsForPersons(movieIds, languageId);
        }

        public void AddPersonLocalization(PersonLocalization personLocalization)
        {
            _unitOfWork.PersonRepository.AddPersonLocalization(personLocalization);
        }

        public PersonLocalization GetPersonLocalization(int id, int languageId)
        {
            return _unitOfWork.PersonRepository.GetPersonLocalization(id, languageId);
        }

        public void RemovePerson(Person person)
        {
            _unitOfWork.PersonRepository.Remove(person);
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