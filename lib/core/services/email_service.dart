import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  static String emailService = "systemeess@gmail.com";
  static String passwordService = "hrpxvarvkrkcgmdg";

  String subJect;
  String text;

  EmailService(this.subJect, this.text);

  static Future<bool> sendEmail(
    String emailClient,
    String subJect,
    String text,
  ) async {
    final smtpServer = gmail(emailService, passwordService);

    final message = Message()
      ..from = Address(emailService, 'Sistema Gustov APP')
      ..recipients.add(emailClient)
      ..subject = subJect
      ..text = text;
    try {
      await send(message, smtpServer).then((value) {
        return true;
      });
    } on MailerException catch (e) {
      return false;
    }
    return false;
  }

  static Future<void> sendEmailWithPdf({
    required String emailClient,
    required String subJect,
    required String text,
    required File attachment,
  }) async {
    final smtpServer = gmail(emailService, passwordService);
    final message = Message()
      ..from = Address(emailService, 'Sistema Gustov APP')
      ..recipients.add(emailClient)
      ..subject = subJect
      ..text = text
      ..attachments.add(FileAttachment(attachment));

    try {
      final sendReport = await send(message, smtpServer);
      print('Mensaje enviado: ${sendReport.mail}');
    } on MailerException catch (e) {
      print('Error al enviar el mensaje: $e');
    }
  }
}
