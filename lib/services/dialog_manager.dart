import 'package:flutter/material.dart';
import 'package:venu/widgets/loading_alert_dialog.dart';

import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';

class DialogManager {
  DialogManager();

  static void showLoadingDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierColor: const Color(0xff202020),
      // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const LoadingDialog(),
        );
      },
    );
  }

  static Future<void> showCustomDialog(
    BuildContext context,
    Widget alertDialog,
    bool barrierDismissible,
  ) async {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => barrierDismissible,
          child: alertDialog,
        );
      },
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showErrorDialog(
    String errorMessage,
    BuildContext context,
    bool barrierDismissible,
    Function okPressed,
  ) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => barrierDismissible,
          child: ErrorDialog(
            title: errorMessage,
            okFunction: okPressed,
          ),
        );
      },
    );
  }

  static void showTransparentDialog(
    BuildContext context,
    bool barrierDismissible,
  ) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => barrierDismissible,
          child: const LoadingTransparentDialog(),
        );
      },
    );
  }
}
