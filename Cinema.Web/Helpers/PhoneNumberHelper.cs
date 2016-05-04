using System.Text;
using System.Text.RegularExpressions;

namespace Cinema.Web.Helpers
{
    public static class PhoneNumberHelper
    {
        public static string GetPhoneFromMask(string maskedPhone)
        {
            string result = "";
            foreach (var match in Regex.Matches(maskedPhone.Substring(3), @"[^\s()-]\d+"))
            {
                result += match.ToString();
            }
            return result;
        }

        public static string GetMaskFormPhone(string phone)
        {
            StringBuilder stringBuilder = new StringBuilder(phone);
            stringBuilder.Insert(0, "+38 (");
            stringBuilder.Insert(8, ") ");
            stringBuilder.Insert(13, "-");
            stringBuilder.Insert(16, "-");
            return stringBuilder.ToString();
        }
    }
}