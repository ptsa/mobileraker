import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'num_edit_form_viewmodel.dart';

class TextEditFormDialogViewArguments {
  final String? current;
  final int? fraction;

  TextEditFormDialogViewArguments(
      {this.current, this.fraction});
}

class TextEditFormDialogView extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TextEditFormDialogView(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NumEditFormViewModel>.reactive(
      builder: (context, model, child) => Dialog(
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.always,
          key: model.formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  request.title!,
                  style: Theme.of(context).textTheme.headline5,
                ),
                NumField(request: request),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: model.onFormDecline,
                      child: Text(request.secondaryButtonTitle!),
                    ),
                    TextButton(
                      onPressed: model.onFormConfirm,
                      child: Text(request.mainButtonTitle!),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => NumEditFormViewModel(request, completer),
    );
  }
}

class NumField extends ViewModelWidget<NumEditFormViewModel> {
  const NumField({Key? key, required this.request}) : super(key: key);
  final DialogRequest request;

  @override
  Widget build(BuildContext context, NumEditFormViewModel model) {
    TextEditFormDialogViewArguments passedData = request.data;
    int frac = passedData.fraction ?? 0;

    return FormBuilderTextField(
      autofocus: true,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context)
      ]),
      valueTransformer: (String? text) => text == null ? 0 : num.tryParse(text),
      initialValue: passedData.current,
      name: 'newValue',
      style: Theme.of(context).inputDecorationTheme.counterStyle,
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: false),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        contentPadding: const EdgeInsets.all(8.0),
        labelText: request.description,
      ),
    );
  }
}