using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class PersonRepository : GenericRepositrory<Person>, IPersonRepository
    {
        private CinemaDatabaseEntities PersonContext => Context;

        public PersonRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

        public void AddPersonLocalization(PersonLocalization personLocalization)
        {
            PersonContext.PersonLocalizations.Add(personLocalization);
        }

        public List<PersonLocalization> GetAllPersonLocalizations(int languageId)
        {
            return PersonContext.PersonLocalizations.Where(x => x.LanguageId == languageId).ToList();
        }

        public List<int> GetActorIdsForMovie(int movieId)
        {
            IEnumerable<Person> persons = PersonContext.Persons.Where(x => x.ActorInMovies.Any(z => z.Id == movieId));
            return (from person in persons select person.Id).ToList();
        }

        public List<string> GetActorLocalizations(ICollection<Person> actors, int languageId)
        {
            return actors.Select(actor =>
                PersonContext.PersonLocalizations.FirstOrDefault(x => x.PersonId == actor.Id).Name).ToList();
        }

        public PersonLocalization GetPersonLocalization(int directorId, int languageId)
        {
            return PersonContext.PersonLocalizations.FirstOrDefault(x =>
               x.PersonId == directorId &&
               x.LanguageId == languageId);
        }

        public List<Person> GetSelectedActors(List<int> actorIds)
        {
            return PersonContext.Persons.Where(x => actorIds.Contains(x.Id)).ToList();
        }

        public List<PersonLocalization> GetActorLocalizationsForMovies(List<int> personIds, int languageId)
        {
            return PersonContext.PersonLocalizations.Where(x =>
               personIds.Contains(x.PersonId) &&
               x.LanguageId == languageId).ToList();
        }
    }
}