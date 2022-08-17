import 'package:flutter/material.dart';
import 'package:mobileraker/service/ui/dialog_service.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {Key? key, required this.dialogRequest, required this.completer})
      : super(key: key);
  final DialogRequest dialogRequest;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: Theme.of(context).dialogTheme.titleTextStyle,
      contentTextStyle: Theme.of(context).dialogTheme.contentTextStyle,
      title: dialogRequest.title != null
          ? Text(
              key: const Key('dialog_text_title'),
              dialogRequest.title!,
            )
          : null,
      content: dialogRequest.body != null
          ? Text(
              key: const Key('dialog_text_content'),
              dialogRequest.body!,
            )
          : null,
      actions: [
        TextButton(
          onPressed: () => completer(DialogResponse()),
          child: Text(
              dialogRequest.cancelBtn ??
                  MaterialLocalizations.of(context).cancelButtonLabel,
              style: TextStyle(color: dialogRequest.cancelBtnColor)),
        ),
        TextButton(
            onPressed: () => completer(DialogResponse.confirmed()),
            child: Text(dialogRequest.confirmBtn ?? 'CONFIRM',
                style: TextStyle(color: dialogRequest.confirmBtnColor))),
      ],
    );
  }
}