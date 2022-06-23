import 'package:flutter/material.dart';
import 'package:simple_json_form/src/utils/responsive.dart';
import 'package:simple_json_form/src/widgets/primary_button.dart';
import 'package:simple_json_form/src/widgets/text_cfirst.dart';

class DialogForm {
  DialogForm({
    required this.buildContext,
    this.loading,
  });
  final BuildContext buildContext;
  final Widget? loading;

  static DialogForm of({
    required BuildContext context,
    Widget? loading,
  }) =>
      DialogForm(
        buildContext: context,
        loading: loading,
      );

  void infoDialog({
    String? title,
    String? description,
    bool withButton = false,
    Function()? func,
    String? labelButton,
  }) {
    showDialog(
        context: buildContext,
        builder: (ctx) {
          return AlertDialog(
            title: Icon(
              Icons.info_outline,
              color: Theme.of(ctx).primaryColor,
              size: Responsive.of(buildContext).dp(4),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextCFirst(
                  title ?? 'Failed validations',
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.of(buildContext).dp(2.2),
                  colorText: Theme.of(ctx).primaryColor,
                ),
                TextCFirst(
                  description ?? 'Some fields require your validation',
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
