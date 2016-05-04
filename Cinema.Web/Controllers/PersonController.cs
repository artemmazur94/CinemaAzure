using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using System.Web.Routing;
using Cinema.DataAccess;
using Cinema.Services.Contracts;
using Cinema.Web.Helpers;
using Cinema.Web.Models;

namespace Cinema.Web.Controllers
{
    [HandleLogError]
    public class PersonController : Controller
    {
        private readonly IPersonService _personService;
        private readonly IMovieService _movieService;

        public PersonController(IPersonService personService, IMovieService movieService)
        {
            _personService = personService;
            _movieService = movieService;
        }

        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
            LanguageHelper.InitializeCulture(HttpContext);
        }

        // GET: People
        public ActionResult Index()
        {
            List<Person> persons = _personService.GetAllPersons();
            List<PersonLocalization> personLocalizations = _personService.GetAllPersonLocalizations(LanguageHelper.CurrnetCulture);

            List<int> movieIds =
                (from person in persons
                 from movieAsActor in person.ActorInMovies
                 select movieAsActor.Id).Distinct().ToList();

            movieIds.AddRange(
                (from person in persons
                 from movieAsDirector in person.DirectorOfMovies
                 select movieAsDirector.Id).Distinct());

            List<MovieLocalization> movieLocalizations = _personService.GetMovieLocalizations(movieIds,
                LanguageHelper.CurrnetCulture);

            var models = (from person in persons
                select new PerosonListViewModel()
                {
                    Id = person.Id,
                    Photo = person.Photo,
                    Name = personLocalizations.FirstOrDefault(x => x.PersonId == person.Id)?.Name,
                    ActorInMovies =
                        (from movieLocalization in
                            movieLocalizations.Where(
                                x => person.ActorInMovies.Contains(
                                    person.ActorInMovies.FirstOrDefault(z => z.Id == x.MovieId)))
                            select movieLocalization.Name).ToList(),
                    DirectorOfMovies =
                        (from movieLocaliztion in
                            movieLocalizations.Where(
                                x => person.DirectorOfMovies.Contains(
                                    person.DirectorOfMovies.FirstOrDefault(z => z.Id == x.MovieId)))
                            select movieLocaliztion.Name).ToList()
                }).ToList();

            return View(models);
        }

        // GET: People/Create
        [AuthorizeAdmin]
        public ActionResult Create()
        {
            return View("CreateEdit", new PersonAddEditViewModel());
        }

        // GET: People/Edit/5
        [AuthorizeAdmin]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Person person = _personService.GetPerson(id.Value);
            if (person == null)
            {
                return HttpNotFound();
            }
            var model = new PersonAddEditViewModel()
            {
                Id = id.Value,
                Name = _personService.GetPersonLocalization(id.Value, LanguageHelper.CurrnetCulture).Name
            };
            return View("CreateEdit", model);
        }

        // POST: Persons/CreateEdit
        [HttpPost]
        [AuthorizeAdmin]
        [ValidateAntiForgeryToken]
        public ActionResult CreateEdit(PersonAddEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.Id <= 0)
                {
                    if (model.Photo != null && ImageHelper.IsImage(model.Photo.FileName))
                    {
                        AddPerson(model);
                        return RedirectToAction("Index");
                    }
                    ModelState.AddModelError(String.Empty, "Photo wasn't provided or bad format. Allowed formats are '.png', '.jpeg', '.jpg'.");
                }
                else
                {
                    if (model.Photo == null || ImageHelper.IsImage(model.Photo.FileName))
                    {
                        EditPerson(model);
                        return RedirectToAction("Index");
                    }
                    ModelState.AddModelError(String.Empty, "Photo has bad format. Allowed formats are '.png', '.jpeg', '.jpg'.");
                }
            }
            return View(model);
        }

        private void AddPerson(PersonAddEditViewModel model)
        {
            Photo photo = _movieService.SetPhotoToDirectory(model.Photo, Server.MapPath("~/"));
            var person = new Person()
            {
                Photo = photo
            };
            _personService.AddPersonLocalization(new PersonLocalization()
            {
                Person = person,
                Name = model.Name,
                LanguageId = (int) LanguageType.EN
            });
            _personService.Commit();
        }

        private void EditPerson(PersonAddEditViewModel model)
        {
            PersonLocalization personLocalization = _personService.GetPersonLocalization(model.Id, (int)LanguageType.EN);
            personLocalization.Name = model.Name;

            if (model.Photo != null)
            {
                Person person = _personService.GetPerson(model.Id);
                if (person.Photo != null)
                {
                    _movieService.DeletePreviousPhotoFromDirectory(person.Photo, Server.MapPath("~/"));
                }
                person.Photo = _movieService.SetPhotoToDirectory(model.Photo, Server.MapPath("~/"));
                personLocalization.Person = person;
            }

            _personService.Commit();
        }

        // GET: People/Delete/5
        [AuthorizeAdmin]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Person person = _personService.GetPerson(id.Value);
            if (person == null)
            {
                return HttpNotFound();
            }
            var model = new DeleteViewModel()
            {
                Name = _personService.GetPersonLocalization(id.Value, LanguageHelper.CurrnetCulture).Name
            };
            return View(model);
        }

        // POST: People/Delete/5
        [HttpPost, ActionName("Delete")]
        [AuthorizeAdmin]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Person person = _personService.GetPerson(id);
            if (person.Photo != null)
            {
                _movieService.DeletePreviousPhotoFromDirectory(person.Photo, Server.MapPath("~/"));
            }
            _personService.RemovePerson(person);
            _personService.Commit();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _personService.Dispose();
                _movieService.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
