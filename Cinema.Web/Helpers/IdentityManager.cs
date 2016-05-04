using System;
using System.Security.Principal;
using System.Web;
using System.Web.Security;

namespace Cinema.Web.Helpers
{
    public static class IdentityManager
    {
        public static int GetProfileIdFromAuthCookie(HttpContextBase context)
        {
            return Int32.Parse(((FormsIdentity)context.User.Identity).Ticket.UserData.Split(' ')[1]);
        }

        public static bool IsAdmin(this IPrincipal user)
        {
            if (!user.Identity.IsAuthenticated) return false;
            return Boolean.Parse(((FormsIdentity) user.Identity).Ticket.UserData.Split(' ')[0]);
        }
    }
}