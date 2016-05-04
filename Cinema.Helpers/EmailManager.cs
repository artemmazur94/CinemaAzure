using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.Text;

namespace Cinema.Helpers
{
    public static class EmailManager
    {
        public static void RestorePasswordEmail(string token, string email, string username)
        {
            var mailMessage = new MailMessage(ConfigurationSettings.AppSettings[""], email);

            var emailBody = new StringBuilder();
            emailBody.Append("Dear" + username + ",<br/><br/>");
            emailBody.Append("Please click on the following link to restore your password:<br/>");
            emailBody.Append("" + token);
            emailBody.Append("<br/><br/>");
            emailBody.Append("<strong>Cinema administration</strong>");

            mailMessage.IsBodyHtml = true;

            mailMessage.Body = emailBody.ToString();
            mailMessage.Subject = "Restore password";

            var smtpClient = new SmtpClient("smtp.gmail.com", 587)
            {
                Credentials = new NetworkCredential()
                {
                    UserName = "artemmazur94@gmail.com",
                },
                EnableSsl = true
            };


            smtpClient.Send(mailMessage);
        }
    }
}
