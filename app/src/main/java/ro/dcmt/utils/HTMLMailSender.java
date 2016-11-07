package ro.dcmt.utils;
import java.sql.Timestamp;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HTMLMailSender {
	private static Logger logger = LoggerFactory.getLogger(HTMLMailSender.class);
	public static void sendAppointmentNotificationEmail(String to, String clinicName, String doctorName, String pacientName, Timestamp dataProgramare) {
		final String username = "vlad.butnaru@innodevs.com";
		final String password = "Hackthisone1!";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.zoho.com");
		props.put("mail.smtp.port", "587");
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {

			Message message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress("vlad.butnaru@innodevs.com"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject("[" + clinicName + "] - Programare noua la Dr. " + doctorName);
			message.setText("Draga " + pacientName + "," + "\n\n Doctorul " + doctorName + " a creat o programare pentru data de " + dataProgramare.toString() + ". \n\n Iti multumim!");

			Transport.send(message);

			logger.info("sendAppointmentNotificationEmail: " + to);

		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}
}
