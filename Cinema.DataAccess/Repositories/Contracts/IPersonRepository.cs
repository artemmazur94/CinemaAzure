using System;
using System.Collections.Generic;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface IPersonRepository : IDisposable, IRepository<Person>
    {
        void AddPersonLocalization(PersonLocalization personLocalization);

        List<PersonLocalization> GetAllPersonLocalizations(int languageId);

        List<int> GetActorIdsForMovie(int movieId);

        List<string> GetActorLocalizations(ICollection<Person> actors, int languageId);

        PersonLocalization GetPersonLocalization(int directorId, int languageId);

        List<Person> GetSelectedActors(List<int> actorIds);

        List<PersonLocalization> GetActorLocalizationsForMovies(List<int> personIds, int languageId);
    }
}