import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/core/ui/widgets/standard_appbar.dart';
import 'package:a_de_adote/app/pages/ong_register/pdf_view/pdf_view_controller.dart';
import 'package:a_de_adote/app/pages/ong_register/pdf_view/pdf_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewPage extends StatefulWidget {
  const PDFViewPage({super.key});

  @override
  State<PDFViewPage> createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  final ValueNotifier<String> _documentType = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _documentType.value =
          ModalRoute.of(context)?.settings.arguments as String;
      context.read<PdfViewController>().getDocument(_documentType.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _documentType,
      builder: (BuildContext context, String documentType, Widget? child) {
        return Scaffold(
          appBar: StandardAppBar(
            title: documentType == 'termos'
                ? 'Termos de Uso e Condições'
                : 'Política de Privacidade',
          ),
          body: BlocBuilder<PdfViewController, PdfViewState>(
            builder: (context, state) {
              return state.status.matchAny(
                any: () => Container(),
                loading: () => const Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                loaded: () {
                  if (documentType == 'termos') {
                    return PDFView(
                      pageSnap: false,
                      pageFling: false,
                      filePath: state.file?.path,
                    );
                  } else {
                    return PDFView(
                      filePath: state.file?.path,
                    );
                  }
                },
                error: () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 32,
                      color: ProjectColors.danger,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        state.errorMessage ?? '',
                        textAlign: TextAlign.center,
                        style: ProjectFonts.pLight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
