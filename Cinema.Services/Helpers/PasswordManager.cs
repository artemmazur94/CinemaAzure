using System;
using System.Security.Cryptography;
using System.Text;

namespace Cinema.Services.Helpers
{
    public static class PasswordManager
    {
        public static string GenerateSalt(int size)
        {
            var salt = new byte[size];
            using (var random = new RNGCryptoServiceProvider())
            {
                random.GetNonZeroBytes(salt);
                return Convert.ToBase64String(salt);
            }
        }

        public static string GenerateSaltedPassword(string password, string salt)
        {
            string saltedPassword = String.Concat(password, salt);
            using (MD5 md5 = MD5.Create())
            {
                var saltedPasswordHash = md5.ComputeHash(Encoding.Unicode.GetBytes(saltedPassword));
                return Convert.ToBase64String(saltedPasswordHash);
            }
        }
    }
}
