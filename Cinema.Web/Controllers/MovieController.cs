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
    public class MovieController : Controller
    {
        private readonly IMovieService _movieService;

        private const string NAME_COLUMN = "Name";
        private const string GENRE_ID_COLUMN = "GenreId";
        private const string PERSON_ID_COLUMN = "PersonId";
        private const int FIRST_FILMRELEASE_YEAR = 1896;

        public MovieController(IMovieService movieService)
        {
            _movieService = movieService;
        }

        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
            LanguageHelper.InitializeCulture(HttpContext);
        }

        // GET: Movies
        public ActionResult Index()
        {
            List<Movie> movies = _movieService.GetAllMovies();

            List<int> genreIds = (from movie in movies where movie.GenreId != null select movie.GenreId.Value).ToList();

            List<GenreLocalization> genreLocalizations = _movieService.GetGenreLocalizationsForMovies(genreIds,
                LanguageHelper.CurrnetCulture);

            List<int> personIds = (from movie in movies
                from actor in movie.Actors
                select actor.Id).Distinct().ToList();

            personIds.AddRange((from movie in movies let directorId = movie.DirectorId where directorId != null select directorId.Value).Distinct());

            List<PersonLocalization> personLocalizations = _movieService.GetActorLocalizationsForMovies(personIds,
                LanguageHelper.CurrnetCulture);

            var models = (from movie in movies
                select new MoviesListViewModel()
                {
                    MovieId = movie.Id,
                    Name = _movieService.GetMovieLocalization(movie.Id, LanguageHelper.CurrnetCulture).Name,
                    Length = movie.Length,
                    GenreName = genreLocalizations.FirstOrDefault(x => x.GenreId == movie.GenreId)?.Name,
                    ActorNames =
                        (from personLocalization in
                            personLocalizations.Where(
                                x => movie.Actors.Contains(movie.Actors.FirstOrDefault(z => z.Id == x.PersonId)))
                            select personLocalization.Name).ToList(),
                    DirectorName = personLocalizations.FirstOrDefault(x => x.PersonId == movie.DirectorId)?.Name,
                    ReleaseDate = movie.ReleaseDate.ToShortDateString(),
                    Rating = movie.Rating,
                    Photo = movie.Photo
                }).ToList();

            return View(models);
        }

        // GET: Movies/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Movie movie = _movieService.GetMovie(id.Value);
            if (movie == null)
            {
                return HttpNotFound();
            }
            var movieLocalization = _movieService.GetMovieLocalization(id.Value, LanguageHelper.CurrnetCulture);
            var model = new MovieDetailsViewModel()
            {
                Name = movieLocalization.Name,
                Length = movie.Length,
                Description = movieLocalization.Description,
                MovieId = movie.Id,
                ActorNames = _movieService.GetActorLocalizations(movie.Actors, LanguageHelper.CurrnetCulture),
                Photo = movie.Photo,
                ReleaseDate = movie.ReleaseDate.ToShortDateString(),
                Rating = movie.Rating,
                VideoLink = movie.VideoLink
            };
            if (movie.GenreId != null)
            {
                model.GenreName = _movieService.GetGenreLocalizationName(
                    movie.GenreId.Value,
                    LanguageHelper.CurrnetCulture);
            }
            if (movie.DirectorId != null)
            {
                model.DirectorName = _movieService.GetDirectorLocalization(
                    movie.DirectorId.Value,
                    LanguageHelper.CurrnetCulture);
            }
            return View(model);
        }
        
        // GET: Movies/Create
        [AuthorizeAdmin]
        public ActionResult Create()
        {
            ViewBag.GenreLocalizations = new SelectList(_movieService.GetAllGenreLocalizations(LanguageHelper.CurrnetCulture), GENRE_ID_COLUMN, NAME_COLUMN);
            ViewBag.DirectorLocalizations = new SelectList(_movieService.GetAllPersonLocalizations(LanguageHelper.CurrnetCulture), PERSON_ID_COLUMN, NAME_COLUMN);
            ViewBag.ActorsLocalizations = new SelectList(_movieService.GetAllPersonLocalizations(LanguageHelper.CurrnetCulture), PERSON_ID_COLUMN, NAME_COLUMN);
            return View("CreateEdit", new MovieAddEditViewModel());
        }

        // GET: Movies/Edit/5
        [AuthorizeAdmin]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Movie movie = _movieService.GetMovie(id.Value);
            if (movie == null)
            {
                return HttpNotFound();
            }
            var movieLocalization = _movieService.GetMovieLocalization(id.Value, LanguageHelper.CurrnetCulture);
            var model = new MovieAddEditViewModel()
            {
                Id = movie.Id,
                Name = movieLocalization.Name,
                Description = movieLocalization.Description,
                ActorIds = _movieService.GetActorIdsForMovie(movie.Id),
                Length = movie.Length,
                VideoLink = movie.VideoLink,
                ReleaseDate = movie.ReleaseDate
            };
            if (movie.GenreId != null)
            {
                model.GenreId = movie.GenreId.Value;
            }
            if (movie.DirectorId != null)
            {
                model.DirectorId = movie.DirectorId.Value;
            }
            ViewBag.GenreLocalizations = new SelectList(_movieService.GetAllGenreLocalizations(LanguageHelper.CurrnetCulture), GENRE_ID_COLUMN, NAME_COLUMN, movie.GenreId);
            ViewBag.DirectorLocalizations = new SelectList(_movieService.GetAllPersonLocalizations(LanguageHelper.CurrnetCulture), PERSON_ID_COLUMN, NAME_COLUMN, movie.DirectorId);
            ViewBag.ActorsLocalizations = new MultiSelectList(_movieService.GetAllPersonLocalizations(LanguageHelper.CurrnetCulture), PERSON_ID_COLUMN, NAME_COLUMN, model.ActorIds);
            return View("CreateEdit", model);
        }

        // POST: Movies/CreateEdit
        [HttpPost]
        [AuthorizeAdmin]
        [ValidateAntiForgeryToken]
        public ActionResult CreateEdit(MovieAddEditViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.ReleaseDate.Year < FIRST_FILMRELEASE_YEAR)
                {
                    ModelState.AddModelError(String.Empty, "There was no films since 1896 year.");
                }
                else
                {
                    if (model.Poster == null || ImageHelper.IsImage(model.Poster.FileName))
                    {
                        if (model.Id <= 0)
                        {
                            AddMovie(model);
                            return RedirectToAction("Index");

                        }
                        EditMovie(model);
                        return RedirectToAction("Details", new {id = model.Id});
                    }
                    ModelState.AddModelError(String.Empty, "Poster has bad format. Allowed formats are '.png', '.jpeg', '.jpg'.");
                }
            }

            ViewBag.GenreLocalizations = new SelectList(_movieService.GetAllGenreLocalizations(LanguageHelper.CurrnetCulture), GENRE_ID_COLUMN, NAME_COLUMN);
            ViewBag.DirectorLocalizations = new SelectList(_movieService.GetAllPersonLocalizations(LanguageHelper.CurrnetCulture), PERSON_ID_COLUMN, NAME_COLUMN);
            ViewBag.ActorsLocalizations = new SelectList(_movieService.GetAllPersonLocalizations(LanguageHelper.CurrnetCulture), PERSON_ID_COLUMN, NAME_COLUMN);
            return View(model);
        }

        private void AddMovie(MovieAddEditViewModel model)
        {
            Photo photo = null;
            if (model.Poster != null)
            {
                 photo = _movieService.SetPhotoToDirectory(model.Poster, Server.MapPath("~/"));
            }
            
            List<Person> actors = null;
            if (model.ActorIds != null)
            {
                 actors = _movieService.GetSelectedActors(model.ActorIds);
            }
            
            var movie = new Movie()
            {
                Actors = actors,
                DirectorId = model.DirectorId,
                GenreId = model.GenreId,
                Length = model.Length,
                Photo = photo,
                ReleaseDate = model.ReleaseDate,
                VideoLink = model.VideoLink,
                IsDeleted = false
            };
            _movieService.AddMovieLocalization(new MovieLocalization()
            {
                Description = model.Description,
                LanguageId = (int)LanguageType.EN,
                Name = model.Name,
                Movie = movie
            });
            _movieService.Commit();
        }

        private void EditMovie(MovieAddEditViewModel model)
        {
            Movie movie = _movieService.GetMovie(model.Id);
            if (model.ActorIds != null)
            {
                var actors = _movieService.GetSelectedActors(model.ActorIds);
                EditActorsList(movie.Actors, actors);
            }
            else
            {
                movie.Actors.Clear();
            }
            movie.DirectorId = model.DirectorId;
            movie.GenreId = model.GenreId;
            movie.Length = model.Length;
            movie.ReleaseDate = model.ReleaseDate;
            movie.VideoLink = model.VideoLink;
            if (model.Poster != null)
            {
                if (movie.Photo != null)
                {
                    _movieService.DeletePreviousPhotoFromDirectory(movie.Photo, Server.MapPath("~/"));
                }
                movie.Photo = _movieService.SetPhotoToDirectory(model.Poster, Server.MapPath("~/"));
            }

            var movieLocalization = _movieService.GetMovieLocalization(movie.Id, LanguageHelper.CurrnetCulture);
            movieLocalization.Movie = movie;
            movieLocalization.Name = model.Name;
            movieLocalization.Description = model.Description;

            _movieService.Commit();
        }

        private void EditActorsList(ICollection<Person> oldActors, List<Person> newActors)
        {
            foreach (Person oldActor in oldActors.ToList())
            {
                if (!newActors.Contains(oldActor))
                {
                    oldActors.Remove(oldActor);
                }
            }
            foreach (Person newActor in newActors)
            {
                if (!oldActors.Contains(newActor))
                {
                    oldActors.Add(newActor);
                }
            }
        }

        // GET: Movies/Delete/5
        [AuthorizeAdmin]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Movie movie = _movieService.GetMovie(id.Value);
            if (movie == null)
            {
                return HttpNotFound();
            }
            var model = new DeleteViewModel()
            {
                Name = _movieService.GetMovieLocalization(id.Value, LanguageHelper.CurrnetCulture).Name
            };
            return View(model);
        }

        //POST: Movies/Delete/5
        [AuthorizeAdmin]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {

            _movieService.RemoveMovie(id, IdentityManager.GetProfileIdFromAuthCookie(HttpContext));
            _movieService.Commit();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _movieService.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
