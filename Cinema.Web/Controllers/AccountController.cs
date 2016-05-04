using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using Cinema.DataAccess;
using Cinema.Services.Contracts;
using Cinema.Web.Helpers;
using Cinema.Web.Models;
using Facebook;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Newtonsoft.Json;

namespace Cinema.Web.Controllers
{
    [HandleLogError]
    public class AccountController : Controller
    {
        private readonly IAccountService _accountService;
        private readonly IBookingService _bookingService;
        private readonly IMovieService _movieService;

        private const string MESSAGE_KEY = "Message";
        private const string FACEBOOK_GET_KEY = "FacebookGetPath";
        private const string GOOGLE_ACCESS_TOKEN_URL_KEY = "GoogleAccessTokenUrl";
        private const string FACEBOOK_ACCESS_TOKEN = "FacebookAccessToken";
        private const string GOOGLE_ACCESS_TOKEN = "urn:tokens:google:accesstoken";
        private const string APP_FACEBOOK_ID_KEY = "AppFacebookId";
        private const string APP_FACEBOOK_SECRET_KEY = "AppFacebookSecret";

        private const string EXTERNAL_ACCOUNT_SESSION_KEY = "ExternalAccount";
        private const string IMAGE_URL_SESSION_KEY = "ImageUrl";
        private const string RETURN_URL_SESSION_KEY = "ReturnUrl";
        private const string PROFILE_ID_SESSION_KEY = "ProfileId";

        private const int AUTH_COOKIE_EXPIRATION_MIN = 720;

        protected override void Initialize(RequestContext requestContext)
        {
            base.Initialize(requestContext);
            LanguageHelper.InitializeCulture(HttpContext);
        }

        public AccountController(IAccountService accountService, IBookingService bookingService, IMovieService movieService)
        {
            _accountService = accountService;
            _bookingService = bookingService;
            _movieService = movieService;
        }

        public ActionResult Register()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid) return View();
            if (!_accountService.IsExistUsername(model.Username))
            {
                if (!_accountService.IsExistEmail(model.Email))
                {
                    model.Email = model.Email.ToLower();
                    var account = new Account()
                    {
                        Login = model.Username,
                        Password = model.Password,
                        Profile = new Profile()
                        {
                            Name = model.Name,
                            Surname = model.Surname,
                            Email = model.Email
                        }
                    };
                    _accountService.CreatePassword(account);
                    _accountService.AddAccount(account);
                    _accountService.Commit();
                    SignIn(account.Profile, true);
                    return RedirectToAction("Index", "Movie");
                }
                ModelState.AddModelError("", "User with this email already exists");
                return View(model);
            }
            ModelState.AddModelError("", "User with this username already exists");
            return View(model);
        }

        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        // TODO: Post from 2 different login pages in one browser (antiforgety tocken expects loged in user)
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid) return View();
            if (!_accountService.IsExistUsername(model.Username))
            {
                ModelState.AddModelError("", "There is no user with such username");
                return View();
            }
            if (_accountService.IsValidLoginData(model.ToAccount()))
            {
                Profile profile = _accountService.GetProfileByUsername(model.Username);
                SignIn(profile, model.RememberMe);
                return RedirectToLocal(returnUrl);
            }
            ModelState.AddModelError("", "Wrong password");
            return View();
        }

        public ActionResult RestorePassword()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RestorePassword(EmailViewModel model)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            if (ModelState.IsValid)
            {
                if (_accountService.IsExistEmail(model.Email))
                {
                    _accountService.RestorePassword(model.Email, Request.Url.Authority);
                    _accountService.Commit();
                    Session[MESSAGE_KEY] = "Message for restoring password was sent to your email.";
                    return RedirectToAction("ShowMessage");
                }
                ModelState.AddModelError("", "There is no user with such email.");
            }
            return View();
        }

        [Authorize]
        public ActionResult LogOut()
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Movie");
        }

        [AllowAnonymous]
        public ActionResult UpdatePassword(string token)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            Guid guid;
            if (!Guid.TryParse(token, out guid))
            {
                Session[MESSAGE_KEY] = "Invalid security token.";
                return RedirectToAction("ShowMessage");
            }
            var username = _accountService.GetUsernameByToken(guid);
            if (username == null)
            {
                Session[MESSAGE_KEY] = "Link is invalid or out of date.";
                return RedirectToAction("ShowMessage");
            }
            var model = new UpdatePasswordViewModel()
            {
                Username = username,
                Token = guid
            };
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdatePassword(UpdatePasswordViewModel model)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            if (ModelState.IsValid)
            {
                _accountService.UpdatePassword(model.Username, model.Password);
                _accountService.UseSecurityToken(model.Token);
                _accountService.Commit();
                Session[MESSAGE_KEY] = "Your password was updated.";
                return RedirectToAction("ShowMessage");
            }
            return View(model);
        }

        public ActionResult ShowMessage()
        {
            if (Session[MESSAGE_KEY] == null)
            {
                return RedirectToAction("Index", "Movie");
            }
            string message = (string)Session[MESSAGE_KEY];
            Session[MESSAGE_KEY] = null;
            return View("ShowMessage", model: message);
        }

        [Authorize]
        public ActionResult MyProfile()
        {
            int profileId = IdentityManager.GetProfileIdFromAuthCookie(HttpContext);
            Profile profile = _accountService.GetProfile(profileId);
            var model = new ProfileViewModel()
            {
                Id = profile.Id,
                Name = profile.Name,
                Surname = profile.Surname,
                ImageBytes = profile.ImageData
            };
            if (profile.Phone != null)
            {
                model.Phone = PhoneNumberHelper.GetMaskFormPhone(profile.Phone);
            }
            ViewBag.NonAttachedExternalProviders = _accountService.GetNonAttachedExternalProviders(model.Id);
            return View(model);
        }

        [Authorize]
        public ActionResult ChangePassword()
        {
            return View();
        }

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePassword(ChangePasswordViewModel model)
        {
            if (ModelState.IsValid)
            {
                Profile profile = _accountService.GetProfile(IdentityManager.GetProfileIdFromAuthCookie(HttpContext));
                var account = new Account()
                {
                    Login = profile.Accounts.First().Login,
                    Password = model.OldPassword
                };
                if (_accountService.IsValidLoginData(account))
                {
                    _accountService.ChangePassword(account.Login, model.NewPassword);
                    _accountService.Commit();
                    return RedirectToAction("MyProfile", "Account");
                }
                ModelState.AddModelError(String.Empty, "Wrong old password.");
            }
            return View(model);
        }

        [Authorize]
        public ActionResult EditProfile()
        {
            Profile profile = _accountService.GetProfile(IdentityManager.GetProfileIdFromAuthCookie(HttpContext));
            var model = new ProfileViewModel()
            {
                Id = profile.Id,
                Name = profile.Name,
                Surname = profile.Surname
            };
            if (profile.Phone != null)
            {
                model.Phone = PhoneNumberHelper.GetMaskFormPhone(profile.Phone);
            }
            return View(model);
        }

        [Authorize]
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult EditProfile(ProfileViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.Photo == null || ImageHelper.IsImage(model.Photo.FileName))
                {
                    Profile profile = _accountService.GetProfile(IdentityManager.GetProfileIdFromAuthCookie(HttpContext));
                    profile.Name = model.Name;
                    profile.Surname = model.Surname;
                    profile.Phone = !String.IsNullOrEmpty(model.Phone)
                        ? PhoneNumberHelper.GetPhoneFromMask(model.Phone)
                        : null;
                    if (model.Photo != null)
                    {
                        profile.ImageData = ImageHelper.ConvertImageToByteArray(model.Photo);
                    }
                    _accountService.Commit();
                    UpdateAuthTicket($"{model.Name} {model.Surname}", profile.Id.ToString(), User.IsAdmin());
                    return RedirectToAction("MyProfile", "Account");
                }
                ModelState.AddModelError("", "Photo has bad format.Allowed formats are '.png', '.jpeg', '.jpg'.");
            }
            return View(model);
        }

        [Authorize]
        public ActionResult MyTickets()
        {
            int profileId = IdentityManager.GetProfileIdFromAuthCookie(HttpContext);
            List<Ticket> tickets = _bookingService.GetTicketsForUser(profileId);
            List<int> movieIds = (from ticket in tickets select ticket.Seance.MovieId).Distinct().ToList();
            List<MovieLocalization> movieLocalizations = _movieService.GetMovieLocalizations(movieIds,
                LanguageHelper.CurrnetCulture);
            List<TicketViewModel> ticketViewModels = (from ticket in tickets
                                                      let type = _bookingService.GetSeatType(ticket.Seance.HallId, ticket.Row, ticket.Place)
                                                      select new TicketViewModel()
                                                      {
                                                          Date = ticket.Seance.DateTime.ToLocalTime().Date,
                                                          Time = ticket.Seance.DateTime.ToLocalTime().TimeOfDay,
                                                          HallName = ticket.Seance.Hall.Name,
                                                          Id = ticket.Id,
                                                          MovieName = (from movieLocalization in movieLocalizations
                                                                       where ticket.Seance.MovieId == movieLocalization.MovieId
                                                                       select movieLocalization.Name).First(),
                                                          Price = ticket.Seance.SectorTypePrices.FirstOrDefault(x => x.SeatTypeId == type).Price,
                                                          Seat = new HallSeat()
                                                          {
                                                              Row = ticket.Row,
                                                              Place = ticket.Place,
                                                              Type = type
                                                          },
                                                      }).ToList();
            MyTicketsViewModel model = new MyTicketsViewModel()
            {
                PastTickets =
                    (from ticketViewModel in ticketViewModels
                     where ticketViewModel.Date < DateTime.UtcNow
                     select ticketViewModel).ToList(),
                UpcomingTickets =
                    (from ticketViewModel in ticketViewModels
                     where ticketViewModel.Date >= DateTime.UtcNow
                     select ticketViewModel).ToList()
            };
            return View(model);
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLogin(string provider, string returnUrl)
        {
            return new ChallengeResult(provider,
                Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl }));
        }

        [AllowAnonymous]
        public ActionResult ExternalLoginCallback(string returnUrl)
        {
            ExternalLoginInfo loginInfo = HttpContext.GetOwinContext().Authentication.GetExternalLoginInfo();
            if (loginInfo == null)
            {
                Session[MESSAGE_KEY] = "Invalid login data!";
                return RedirectToAction("ShowMessage");
            }
            var externalAccount = new ExternalAccount() { Profile = new Profile() };
            string imageUrl;
            string provider = loginInfo.Login.LoginProvider;
            if (provider == ExternalProviders.Facebook.ToString())
            {
                ExternalLoginCallbackFacebook(loginInfo, externalAccount, out imageUrl);
            }
            else if (provider == ExternalProviders.Google.ToString())
            {
                ExternalLoginCallbackGoogle(loginInfo, externalAccount, out imageUrl);
            }
            else { throw new Exception("Non supported external provider."); }
            if (Session[PROFILE_ID_SESSION_KEY] != null)
            {
                externalAccount.Profile = _accountService.GetProfile((int)Session[PROFILE_ID_SESSION_KEY]);
                Session[PROFILE_ID_SESSION_KEY] = null;
            }
            if (!IsEmailProvided(externalAccount, imageUrl))
            {
                Session[RETURN_URL_SESSION_KEY] = returnUrl;
                return RedirectToAction("EmailProvide");
            }
            ConfigureExternalAccount(externalAccount, imageUrl);
            _accountService.Commit();
            SignIn(externalAccount.Profile, true);
            return RedirectToLocal(returnUrl);
        }

        [AllowAnonymous]
        public ActionResult EmailProvide()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            return View();
        }

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public ActionResult AttachExternalAccount(string provider, string returnUrl)
        {
            Session[PROFILE_ID_SESSION_KEY] = IdentityManager.GetProfileIdFromAuthCookie(HttpContext);
            return new ChallengeResult(provider,
                Url.Action("ExternalLoginCallback", "Account", new { ReturnUrl = returnUrl }));
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult EmailProvide(EmailViewModel model)
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Movie");
            }
            if (ModelState.IsValid)
            {
                string imageUrl = Session[IMAGE_URL_SESSION_KEY] as string;
                ExternalAccount externalAccount = Session[EXTERNAL_ACCOUNT_SESSION_KEY] as ExternalAccount;
                Session[IMAGE_URL_SESSION_KEY] = null;
                Session[EXTERNAL_ACCOUNT_SESSION_KEY] = null;
                if (imageUrl == null || externalAccount == null)
                {
                    throw new Exception("Missing external login data.");
                }
                externalAccount.Profile.Email = model.Email;
                ConfigureExternalAccount(externalAccount, imageUrl);
                string returnUrl = Session[RETURN_URL_SESSION_KEY] as string;
                Session[RETURN_URL_SESSION_KEY] = null;
                _accountService.Commit();
                SignIn(externalAccount.Profile, true);
                return RedirectToLocal(returnUrl);
            }
            ModelState.AddModelError(String.Empty, "Email is invalid.");
            return View(model);
        }

        [AuthorizeAdmin]
        public ActionResult AdminPage()
        {
            var model = new AdminPageViewModel()
            {
                AvarageNumberOfBookedTickets = _bookingService.GetAvarageNumberOfBookedTickets(),
                NumberOfSeancesThisWeek = _bookingService.GetNumberOfSeancesThisWeek(),
                MoviesThisWeek = _bookingService.GetMoviesThisWeek(),
                SeancesThisWeek = new List<SeanceViewModel>()
            };
            _bookingService.GetSeancesThisWeek().ForEach(x => model.SeancesThisWeek.Add(new SeanceViewModel()
            {
                Id = x.Id,
                Date = x.DateTime.ToLocalTime().Date,
                Time = x.DateTime.ToLocalTime().TimeOfDay,
                MovieName = _movieService.GetMovieLocalization(x.MovieId, LanguageHelper.CurrnetCulture).Name
            }));
            return View(model);
        }

        private bool IsEmailProvided(ExternalAccount externalAccount, string imageUrl)
        {
            if (String.IsNullOrEmpty(externalAccount.Profile.Email))
            {
                Session[EXTERNAL_ACCOUNT_SESSION_KEY] = externalAccount;
                Session[IMAGE_URL_SESSION_KEY] = imageUrl;
                return false;
            }
            return true;
        }

        private void ExternalLoginCallbackGoogle(ExternalLoginInfo loginInfo, ExternalAccount externalAccount, out string imageUrl)
        {
            string accessToken = loginInfo.ExternalIdentity.FindFirstValue(GOOGLE_ACCESS_TOKEN);
            Uri apiRequestUri =
                new Uri(ConfigurationManager.AppSettings[GOOGLE_ACCESS_TOKEN_URL_KEY] + accessToken);
            using (var webClient = new WebClient())
            {
                webClient.Encoding = Encoding.UTF8;
                var json = webClient.DownloadString(apiRequestUri);
                dynamic data = JsonConvert.DeserializeObject(json);
                externalAccount.Profile.Email = data.email;
                externalAccount.UserIdentity = data.id;
                externalAccount.Profile.Surname = data.family_name;
                externalAccount.Profile.Name = data.given_name;
                externalAccount.ExternalProviderId = (int)ExternalProviders.Google;
                imageUrl = data.picture;
            }
        }

        private void ExternalLoginCallbackFacebook(ExternalLoginInfo loginInfo, ExternalAccount externalAccount, out string imageUrl)
        {
            string accessToken = loginInfo.ExternalIdentity.FindFirstValue(FACEBOOK_ACCESS_TOKEN);
            var facebook = new FacebookClient(accessToken)
            {
                AppId = ConfigurationManager.AppSettings[APP_FACEBOOK_ID_KEY],
                AppSecret = ConfigurationManager.AppSettings[APP_FACEBOOK_SECRET_KEY]
            };
            dynamic data = JsonConvert.DeserializeObject(facebook.Get(ConfigurationManager.AppSettings[FACEBOOK_GET_KEY]).ToString());
            externalAccount.Profile.Email = data.email;
            externalAccount.UserIdentity = data.id;
            externalAccount.Profile.Surname = data.last_name;
            externalAccount.Profile.Name = data.first_name;
            externalAccount.ExternalProviderId = (int)ExternalProviders.Facebook;
            imageUrl = data.picture.data.url;
        }

        private void ConfigureExternalAccount(ExternalAccount externalAccount, string imageUrl)
        {
            if (_accountService.IsExistEmail(externalAccount.Profile.Email))
            {
                externalAccount.Profile = _accountService.GetProfileByEmail(externalAccount.Profile.Email);
                if (_accountService.IsExistExternalAccount(externalAccount.UserIdentity, externalAccount.ExternalProviderId))
                    if (!_accountService.IsAttachedExternalAccountToCurrentProfile(
                        externalAccount.UserIdentity,
                        externalAccount.ExternalProviderId,
                        externalAccount.Profile.Id))
                    {
                        throw new Exception("Provided email is already attached to other profile.");
                    }
                if (
                    !_accountService.IsExistExternalAccount(externalAccount.UserIdentity,
                        externalAccount.ExternalProviderId) &&
                    _accountService.IsAttachedExternalAccount(externalAccount.Profile.Id,
                        externalAccount.ExternalProviderId))
                {
                    throw new Exception("This profile already has account of this external provider.");
                }
            }
            if (
                !_accountService.IsExistExternalAccount(externalAccount.UserIdentity, externalAccount.ExternalProviderId))
            {
                _accountService.AddExternalAccount(externalAccount);
            }
            if (externalAccount.Profile.ImageData == null)
            {
                using (var webClient = new WebClient())
                {
                    byte[] imageData = webClient.DownloadData(imageUrl);
                    if (imageData != null)
                    {
                        using (var memoryStream = new MemoryStream(imageData))
                        {
                            using (var image = Image.FromStream(memoryStream))
                            {
                                externalAccount.Profile.ImageData = ImageHelper.ConvertImageToByteArray(image);
                            }
                        }
                    }
                }
            }
        }

        private void SignIn(Profile profile, bool rememberMe)
        {
            string username = $"{profile.Name} {profile.Surname}";
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                1,
                username,
                DateTime.UtcNow,
                DateTime.UtcNow.AddMinutes(AUTH_COOKIE_EXPIRATION_MIN),
                rememberMe,
                $"{profile.IsAdmin} {profile.Id}");
            string encTicket = FormsAuthentication.Encrypt(ticket);
            Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Movie");
        }

        private void UpdateAuthTicket(string fullName, string id, bool isAdmin)
        {
            HttpCookie cookie = FormsAuthentication.GetAuthCookie(id, true);
            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);
            var newTicket = new FormsAuthenticationTicket(ticket.Version, fullName, ticket.IssueDate, ticket.Expiration,
                true, $"{isAdmin} {id}", ticket.CookiePath);
            cookie.Value = FormsAuthentication.Encrypt(newTicket);
            Response.Cookies.Set(cookie);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _accountService.Dispose();
                _bookingService.Dispose();
                _movieService.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}