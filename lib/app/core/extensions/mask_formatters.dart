import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatters {
  static MaskFormatters? _instance;

  MaskFormatters._();

  static MaskFormatters get instance {
    _instance ??= MaskFormatters._();
    return _instance!;
  }

  MaskTextInputFormatter get maskCNPJFormatter => MaskTextInputFormatter(
        mask: 'xx.xxx.xxx/xxxx-xx',
        filter: {'x': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );

  MaskTextInputFormatter get maskTelFormatter => MaskTextInputFormatter(
        mask: '(xx) xxxxx-xxxx',
        filter: {'x': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );

  MaskTextInputFormatter get maskCEPFormatter => MaskTextInputFormatter(
        mask: 'xx.xxx-xxx',
        filter: {'x': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );
}

extension MaskFormattersExtensions on BuildContext {
  MaskFormatters get maskFormatters => MaskFormatters.instance;
}
