package EmailNotification;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailNotification {
    public static void sendEmail(String to, String subject, String body) throws AddressException, MessagingException {
        String from = "tankirkjan@gmail.com"; // Replace with your Gmail email address
        String password = "02B8EA85B714DF49C5EC36CA660D8846646F"; // Replace with your Gmail email password

        // Set up the SMTP server properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.elasticemail.com");
        props.put("mail.smtp.port", "2525");
        props.put("mail.smtp.ssl.trust", "smtp.elasticemail.com");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.ciphersuites", "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256");




        // Create a Session object with an authenticator
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        // Create a new email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(body);

        // Send the email message
        Transport.send(message);
    }
    
    public static void main(String args[]) {
    	try {
			sendEmail("tanyasharma2614@gmail.com","hi","hello");
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}