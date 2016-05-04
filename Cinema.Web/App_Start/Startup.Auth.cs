using System.Configuration;
using System.Security.Claims;
using Microsoft.AspNet.Identity;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.Facebook;
using Microsoft.Owin.Security.Google;
using Owin;

namespace Cinema.Web
{
    public partial class Startup
    {
        private const string FACEBOOK_ACCESS_TOKEN = "FacebookAccessToken";
        private const string APP_FACEBOOK_ID_KEY = "AppFacebookId";
        private const string APP_FACEBOOK_SECRET_KEY = "AppFacebookSecret";
        private const string GOOGLE_ACCESS_TOKEN = "urn:tokens:google:accesstoken";
        private const string APP_GOOGLE_ID_KEY = "AppGoogleId";
        private const string APP_GOOGLE_SECRET_KEY = "AppGoogleSecret";
        private const string LOGIN_PATH_KEY = "LoginPath";
        private const string EMAIL_SCOPE = "email";

        public void ConfigureAuth(IAppBuilder app)
        {
            app.UseCookieAuthentication(new CookieAuthenticationOptions()
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString(ConfigurationManager.AppSettings[LOGIN_PATH_KEY])
            });

            app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

            var facebookOptions = new FacebookAuthenticationOptions()
            {
                AppId = ConfigurationManager.AppSettings[APP_FACEBOOK_ID_KEY],
                AppSecret = ConfigurationManager.AppSettings[APP_FACEBOOK_SECRET_KEY],
                Provider = new FacebookAuthenticationProvider()
                {
                    OnAuthenticated = async context => context.Identity.AddClaim( new Claim(FACEBOOK_ACCESS_TOKEN, context.AccessToken))
                }
            };
            facebookOptions.Scope.Add(EMAIL_SCOPE);
            app.UseFacebookAuthentication(facebookOptions);


            var googleOptions = new GoogleOAuth2AuthenticationOptions()
            {
                ClientId = ConfigurationManager.AppSettings[APP_GOOGLE_ID_KEY],
                ClientSecret = ConfigurationManager.AppSettings[APP_GOOGLE_SECRET_KEY],
                Provider = new GoogleOAuth2AuthenticationProvider()
                {
                    OnAuthenticated = async context => context.Identity.AddClaim(new Claim(GOOGLE_ACCESS_TOKEN, context.AccessToken))
                }
            };
            app.UseGoogleAuthentication(googleOptions);
        }
    }
}