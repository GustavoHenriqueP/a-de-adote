import 'package:a_de_adote/app/pages/ong_register/pdf_view/pdf_view_controller.dart';
import 'package:a_de_adote/app/pages/ong_register/pdf_view/pdf_view_page.dart';
import 'package:a_de_adote/app/services/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PDFViewRouter {
  PDFViewRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<PDFApi>(
            create: ((context) => PDFApi()),
          ),
          Provider<PdfViewController>(
            create: ((context) => PdfViewController(
                  context.read(),
                )),
          ),
        ],
        child: const PDFViewPage(),
      );
}
