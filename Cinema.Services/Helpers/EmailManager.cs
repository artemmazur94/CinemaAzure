using System.Collections.Generic;
using System.Net.Mail;
using System.Text;
using System.Configuration;
using System.Net;

namespace Cinema.Services.Helpers
{
    public static class EmailManager
    {
        private const string SENDER_EMAIL_KEY = "SenderEmail";
        private const string PASSWORD_EMAIL_KEY = "PasswordEmail";
        private const string SMTP_CLIENT_HOST = "smtp.gmail.com";

        public static void RestorePasswordEmail(string restoreUrl, string toEmail, string fullName)
        {
            using (var mailMessage = new MailMessage(ConfigurationManager.AppSettings[SENDER_EMAIL_KEY], toEmail))
            {
                var emailBody = new StringBuilder();
                emailBody.Append($"Dear {fullName},<br/><br/>");
                emailBody.Append("Please click on the following link to restore your password:<br/>");
                emailBody.Append(restoreUrl);
                emailBody.Append("<br/><br/>");
                emailBody.Append("<strong>Cinema administration</strong>");

                mailMessage.IsBodyHtml = true;
                mailMessage.Body = emailBody.ToString();
                mailMessage.Subject = "Restore password";

                SendEmail(mailMessage);
            }
        }

        public static void TicketEmail(List<string> ticketFilesPath ,string toEmail, string fullName)
        {
            using (var mailMessage = new MailMessage(ConfigurationManager.AppSettings[SENDER_EMAIL_KEY], toEmail))
            {
                var emailBody = new StringBuilder();
                emailBody.Append($"Dear {fullName}, <br/><br/>");
                emailBody.Append("You booked tickets in our cinema.<br/>");
                emailBody.Append("Tickets attached to this email as *.pdf files.");
                emailBody.Append("<br/><br/>");
                emailBody.Append("<strong>Cinema administration</strong>");

                mailMessage.IsBodyHtml = true;
                mailMessage.Body = emailBody.ToString();
                mailMessage.Subject = "Booked tickets";

                ticketFilesPath.ForEach(x => mailMessage.Attachments.Add(new Attachment(x)));

                SendEmail(mailMessage);
            }
        }

        private static void SendEmail(MailMessage mailMessage)
        {
            using (var smtpClient = new SmtpClient(SMTP_CLIENT_HOST, 587))
            {
                smtpClient.UseDefaultCredentials = true;
                smtpClient.Credentials = new NetworkCredential()
                {
                    UserName = ConfigurationManager.AppSettings[SENDER_EMAIL_KEY],
                    Password = ConfigurationManager.AppSettings[PASSWORD_EMAIL_KEY]
                };
                smtpClient.EnableSsl = true;

                smtpClient.Send(mailMessage);
            }
        }
    }
}
