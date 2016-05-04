using System;
using System.Security.Cryptography;
using System.Text;
using static System.String;

namespace Cinema.Helpers
{
    public static class PasswordManager
    {
        public static string GenerateSalt(int size)
        {
            var salt = new byte[size];
            using (var random = new RNGCryptoServiceProvider())
            {
                random.GetNonZeroBytes(salt);
            }
            return Convert.ToBase64String(salt);
        }

        public static string GenerateSaltedPassword(string password, string salt)
        {
            string saltedPassword = Concat(password, salt);
            using (MD5 md5 = MD5.Create())
            {
                var saltedPasswordHash = md5.ComputeHash(Encoding.Unicode.GetBytes(saltedPassword));
                return Convert.ToBase64String(saltedPasswordHash);
            }
        }
    }
}
