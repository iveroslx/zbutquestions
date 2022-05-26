using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;


public class Mailer
{
    public const string server = "mail.yourserver.com";
    public const int port = 25;
    public const string DefaultSender = "no-reply@yourcompany.com";
    public const string DefaultPassword = "SecretSquirrel";

    public const string DefaultRecipient = "no-reply@yourcompany.com";

    public static void SendMail(bool defaultSender, string subject, string body)
    {
        SendMail(DefaultSender, DefaultPassword, DefaultRecipient, subject, body,string.Empty);
    }


    public static void SendMail(string defaultSender, string defaultPassword, string recipient, string subject, string body, string cc)
    {
        MailMessage message = new MailMessage(defaultSender, recipient, subject, body) { IsBodyHtml = true, From = new MailAddress(defaultSender, "Your Name") };
        if (cc != string.Empty)
        {
            message.CC.Add(cc);
        }
        using (SmtpClient mail = new SmtpClient())
        {
            mail.Port = port;
            mail.DeliveryMethod = SmtpDeliveryMethod.Network;
            mail.UseDefaultCredentials = false;
            mail.Host = server;
            mail.Credentials = new System.Net.NetworkCredential(DefaultSender, defaultPassword, "yourserver");
            //mail.EnableSsl = true;
            try
            {
                return;
                //тук се изпълнява кода за изпращане по имейл
                //mail.Send(message);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}