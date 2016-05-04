using System;
using System.Web;

namespace Cinema.Web.Helpers
{
    public static class LanguageHelper
    {
        private static int _currentCulture = -1;

        private const string COOKIE_LANGUAGE_KEY = "LanguageId";

        public static int CurrnetCulture
        {
            get
            {
                if (_currentCulture < 0)
                {
                    throw new Exception("Current culture isn't initializaed in LanguageHelper");
                }
                return _currentCulture;
            }
        }

        public static void InitializeCulture(HttpContextBase context)
        {
            if (context.Request.Cookies[COOKIE_LANGUAGE_KEY] != null)
            {
                Int32.TryParse(context.Request.Cookies[COOKIE_LANGUAGE_KEY].Value, out _currentCulture);
            }
            _currentCulture = (int)LanguageType.EN;
        }
    }
}