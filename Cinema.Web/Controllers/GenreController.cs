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
    public class GenreController : Controller
    {
        private readonly IGenreService _genreService;
        private readonly IMovieService _movieService;

        public GenreController(IGenreService genreService, IMovieService movieService)
        {
            _genreService = genreService;
            _movieService = movieService;
        }

        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
            LanguageHelper.InitializeCulture(HttpContext);
        }

        // GET: Genre
        public ActionResult Index()
        {
            var genreLocalizations = _movieService.GetAllGenreLocalizations(LanguageHelper.CurrnetCulture);
            var models = (from genreLocalization in genreLocalizations
                select new GenreViewModel()
                {
                    Id = genreLocalization.GenreId,
                    Name = genreLocalization.Name,
                    Description = genreLocalization.Description
                }).ToList();
            return View(models);
        }

        // GET: Genre/Create
        [AuthorizeAdmin]
        public ActionResult Create()
        {
            return View("CreateEdit", new GenreViewModel());
        }

        // GET: Genre/Edit/5
        [AuthorizeAdmin]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Genre genre = _genreService.GetGenre(id.Value);
            if (genre == null)
            {
                return HttpNotFound();
            }
            GenreLocalization genreLocalization = _genreService.GetGenreLocalization(id.Value,
                LanguageHelper.CurrnetCulture);
            var model = new GenreViewModel()
            {
                Id = genre.Id,
                Name = genreLocalization.Name,
                Description = genreLocalization.Description
            };
            return View("CreateEdit", model);
        }

        // POST: Genre/Create
        [HttpPost]
        [AuthorizeAdmin]
        [ValidateAntiForgeryToken]
        public ActionResult CreateEdit(GenreViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.Id <= 0)
                {
                    AddGenre(model);
                }
                else
                {
                    EditGenre(model);
                }
                return RedirectToAction("Index");
            }
            return View(model);
        }

        private void AddGenre(GenreViewModel model)
        {
            var genre = new Genre();
            _genreService.AddGenreLocalization(new GenreLocalization()
            {
                Genre = genre,
                Description = model.Description,
                Name = model.Name,
                LanguageId = (int) LanguageType.EN
            });
            _genreService.Commit();
        }

        private void EditGenre(GenreViewModel model)
        {
            GenreLocalization genreLocalization = _genreService.GetGenreLocalization(model.Id, (int) LanguageType.EN);
            genreLocalization.Name = model.Name;
            genreLocalization.Description = model.Description;
            _genreService.Commit();
        }

        // GET: Genre/Delete/5
        [AuthorizeAdmin]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Genre genre = _genreService.GetGenre(id.Value);
            if (genre == null)
            {
                return HttpNotFound();
            }
            var model = new DeleteViewModel()
            {
                Name = _genreService.GetGenreLocalization(id.Value, LanguageHelper.CurrnetCulture).Name
            };
            return View(model);
        }

        // POST: Genre/Delete/5
        [HttpPost, ActionName("Delete")]
        [AuthorizeAdmin]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Genre genre = _genreService.GetGenre(id);
            _genreService.RemoveGenre(genre);
            _genreService.Commit();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _genreService.Dispose();
                _movieService.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
