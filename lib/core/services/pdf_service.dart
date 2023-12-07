import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_application_gustov/presentation/bloc/vacation_request/resources/content_pdf_formater.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfService {
  static Future<void> copyAssetToFilePdf(
    String assetPath,
    String filePath,
  ) async {
    final File file = File(filePath);
    if (await file.exists()) {
      return;
    }

    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    await file.writeAsBytes(bytes);
  }

  static Future<pw.Font> getFont() async {
    final appDir = await getApplicationDocumentsDirectory();

    const fontAssetsPath = 'assets/fonts/muli/Muli.ttf';
    final fontLocalPath = '${appDir.path}/Muli.ttf';

    await copyAssetToFilePdf(fontAssetsPath, fontLocalPath);

    final fontData = File('${appDir.path}/Muli.ttf').readAsBytesSync();
    final ttfFont = pw.Font.ttf(fontData.buffer.asByteData());
    return ttfFont;
  }

  static Future<File> createPdf({Widget? content}) async {
    final appDir = await getApplicationDocumentsDirectory();
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Container(
              padding: const pw.EdgeInsets.all(20),
              child: content,
            ),
          );
        },
      ),
    );
    final pdfFile = File('${appDir.path}/recibo.pdf');

    await pdfFile.writeAsBytes(await pdf.save());

    return pdfFile;
  }
}
