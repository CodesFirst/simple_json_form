import 'package:flutter/material.dart';
import 'package:simple_json_form/src/widgets/primary_button.dart';

class DialogForm {
  DialogForm({
    required this.buildContext,
    this.loading,
  });
  final BuildContext buildContext;
  final Widget? loading;

  static DialogForm of(BuildContext context, Widget? loading) => DialogForm(
        buildContext: context,
        loading: loading,
      );

  void infoDialog({
    required String title,
    required String description,
    bool withButton = false,
    Function()? func,
    String? labelButton,
  }) {
    showDialog(
        context: buildContext,
        builder: (ctx) {
          return AlertDialog(
            title: Icon(Icons.info_outline, color: Theme.of(ctx).primaryColor),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                ),
                const SizedBox(
                  height: 20,
                ),
                withButton
                    ? PrimaryButton(
                        onPressed: func!,
                        text: labelButton ?? "Ok",
                      )
                    : Container(),
              ],
            ),
          );
        });
  }

  void loadingDialog({required String title}) {
    showDialog(
        barrierDismissible: false,
        context: buildContext,
        builder: (ctx) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                loading ?? const CircularProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }
}
