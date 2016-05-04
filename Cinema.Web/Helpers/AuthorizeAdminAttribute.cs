using System;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;

namespace Cinema.Web.Helpers
{
    [AttributeUsage(AttributeTargets.Method)]
    public class AuthorizeAdminAttribute : AuthorizeAttribute
    {
        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            if (httpContext == null)
            {
                throw new ArgumentNullException(nameof(httpContext));
            }
            IPrincipal user = httpContext.User;
            if (!user.IsAdmin())
            {
                return false;
            }
            return true;
        }
    }
}