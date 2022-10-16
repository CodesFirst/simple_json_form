import 'package:flutter/material.dart';
import 'package:simple_json_form/src/utils/responsive.dart';
import 'package:simple_json_form/src/widgets/primary_button.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    Key? key,
    required this.lengthForm,
    required this.indexForm,
    required this.nextText,
    required this.previousText,
    required this.submitText,
    this.onSubmit,
    this.onNext,
    this.onPrevious,
  }) : super(key: key);

  final int lengthForm;
  final int indexForm;
  final String nextText;
  final String previousText;
  final String submitText;
  final Function()? onSubmit;
  final Function()? onNext;
  final Function()? onPrevious;

  @override
  Widget build(BuildContext context) {
    return lengthForm == 1
        ? _OneButtonForm(
            text: submitText,
            onPressed: onSubmit,
          )
        : _ManyButtonForm(
            isFinish: lengthForm == indexForm + 1,
            nextText: nextText,
            previousText: previousText,
            indexForm: indexForm,
            submitText: submitText,
            onNext: onNext,
            onPrevious: onPrevious,
            onSubmit: onSubmit,
          );
  }
}

class _OneButtonForm extends StatelessWidget {
  const _OneButtonForm({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.of(context).dp(2),
      ),
      child: PrimaryButton(
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
        text: text,
      ),
    );
  }
}

class _ManyButtonForm extends StatelessWidget {
  const _ManyButtonForm({
    Key? key,
    required this.isFinish,
    required this.nextText,
    required this.previousText,
    required this.submitText,
    required this.indexForm,
    this.onSubmit,
    this.onNext,
    this.onPrevious,
  }) : super(key: key);

  final bool isFinish;
  final int indexForm;
  final String nextText;
  final String previousText;
  final String submitText;
  final Function()? onSubmit;
  final Function()? onNext;
  final Function()? onPrevious;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.of(context).dp(2),
      ),
      child: isFinish
          ? Column(
              children: [
                PrimaryButton(
                  onPressed: () {
                    if (onPrevious != null) onPrevious!();
                  },
                  text: previousText,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                    onPressed: () {
                      if (onSubmit != null) onSubmit!();
                    },
                    text: submitText,
                    overflow: TextOverflow.ellipsis,
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            )
          : indexForm == 0
              ? PrimaryButton(
                  onPressed: () {
                    if (onNext != null) onNext!();
                  },
                  text: nextText,
                )
              : Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      onPressed: () {
                        if (onPrevious != null) onPrevious!();
                      },
                      text: previousText,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      onPressed: () {
                        if (onNext != null) onNext!();
                      },
                      text: nextText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
    );
  }
}
