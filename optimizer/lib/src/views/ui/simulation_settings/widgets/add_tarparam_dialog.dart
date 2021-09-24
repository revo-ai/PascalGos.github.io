import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';

typedef void ParameterCallback(TargetParameter tarParam);

class AddTarParamDialog extends StatefulWidget {
  final ParameterCallback callback;
  const AddTarParamDialog({Key? key, required this.callback}) : super(key: key);

  @override
  _AddTarParamDialogState createState() => new _AddTarParamDialogState();
}

class _AddTarParamDialogState extends State<AddTarParamDialog> {
  String errorParameterKey = "";
  String errorComboBox = "";
  String errorBounds = "";

  final values = [
    'min',
    'max',
    'equals',
    'less than',
    'less than or equal to',
    'greater than',
    'greater than or equal to'
  ];
  Widget swapWidget = Expanded(
    flex: 2,
    child: Row(
      children: [
        Spacer(
          flex: 1,
        ),
        SizedBox(
          width: 10,
        ),
        Spacer(
          flex: 1,
        ),
      ],
    ),
  );
  String? comboBoxValue;

  TextEditingController parameterKeyController = TextEditingController();
  TextEditingController boundsStartController = TextEditingController();
  TextEditingController boundsEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Add new parameter'),
      content: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          'Please enter the relevant information',
        ),
        SizedBox(
          height: 10,
        ),
        TextBox(
          header: 'Enter Parameter Key',
          placeholder: '...',
          controller: parameterKeyController,
          maxLines: 1,
        ),
        Text(
          errorParameterKey,
          style: TextStyle(
            color: Colors.errorPrimaryColor,
            fontSize: FluentTheme.of(context).typography.caption!.fontSize,
            fontWeight: FluentTheme.of(context).typography.caption!.fontWeight,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: InfoLabel(
                label: 'Operation',
                child: Combobox<String>(
                  placeholder: Text('Choose Operation'),
                  isExpanded: true,
                  items: values
                      .map((e) => ComboboxItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  value: comboBoxValue,
                  //TODO: Fix setState, Screen doesn't update
                  onChanged: (value) {
                    switch (value) {
                      case 'min':
                        swapWidget = Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        );
                        break;

                      case 'max':
                        swapWidget = Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        );
                        break;

                      case 'equals':
                        swapWidget = Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  header: "Value",
                                  placeholder: '...',
                                  controller: boundsStartController,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        );
                        break;

                      case 'less than':
                        swapWidget = Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  header: "Value",
                                  placeholder: '...',
                                  controller: boundsStartController,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        );
                        break;

                      case 'less than or equal to':
                        swapWidget = Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  header: "Value",
                                  placeholder: '...',
                                  controller: boundsStartController,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        );
                        break;

                      case 'greater than':
                        swapWidget = Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  header: "Value",
                                  placeholder: '...',
                                  controller: boundsStartController,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        );
                        break;

                      case 'greater than or equal to':
                        swapWidget = Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  header: "Value",
                                  placeholder: '...',
                                  controller: boundsStartController,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        );
                        break;
                    }

                    if (value != null) setState(() => comboBoxValue = value);
                  },
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            swapWidget,
          ],
        ),
        Text(
          errorComboBox + " " + errorBounds,
          style: TextStyle(
            color: Colors.errorPrimaryColor,
            fontSize: FluentTheme.of(context).typography.caption!.fontSize,
            fontWeight: FluentTheme.of(context).typography.caption!.fontWeight,
          ),
        ),
      ]),
      actions: [
        Button(
          child: Text('Add'),
          onPressed: () {
            setState(() {
              errorComboBox = validateComboBoxValue(comboBoxValue);
              errorParameterKey =
                  validateParameterKey(parameterKeyController.text);
              if (comboBoxValue != null &&
                  comboBoxValue != 'max' &&
                  comboBoxValue != 'min') {
                errorBounds = validateBounds(boundsStartController.text);
              }

              if (validateForm(errorParameterKey, errorComboBox, errorBounds)) {
                List<double> bounds = [];
                switch (comboBoxValue!) {
                  case 'min':
                    bounds.add(double.parse('0'));
                    break;
                  case 'max':
                    bounds.add(double.parse('0'));
                    break;
                  case 'equals':
                    bounds.add(double.parse(boundsStartController.text));
                    break;
                  case 'less than':
                    bounds.add(double.parse(boundsStartController.text));
                    break;
                  case 'less than or equal to':
                    bounds.add(double.parse(boundsStartController.text));
                    break;
                  case 'greater than':
                    bounds.add(double.parse(boundsStartController.text));
                    break;
                  case 'greater than or equal to':
                    bounds.add(double.parse(boundsStartController.text));
                    break;
                }
                Operation operation = Operation(key: "");

                if (bounds.isEmpty) {
                  operation = Operation(key: comboBoxValue!);
                } else {
                  operation = Operation(key: comboBoxValue!, bounds: bounds);
                }
                TargetParameter tarParam = TargetParameter(
                  key: parameterKeyController.text,
                  operation: operation,
                );
                widget.callback(tarParam);
                Navigator.pop(context);
                //TODO: Verify parameters maxlength
                // if (parameters.length < 6) {
                // }

              }
            });
          },
        ),
        Button(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  String validateParameterKey(String value) {
    if (value == "") {
      return "Please provide a parameter key";
    } else
      return "";
  }

  String validateComboBoxValue(String? value) {
    if (value == "" || value == null) {
      return "Please choose an operation";
    } else
      return "";
  }

  String validateBounds(String value1) {
    if ((value1 == "")) {
      return "Please provide a value";
    } else if (double.tryParse(value1) == null) {
      return "Please use a numeric value";
    } else
      return "";
  }

  bool validateForm(
    String value1,
    String value2,
    String value3,
  ) {
    if (value1 == "" && value2 == "" && value3 == "") {
      return true;
    } else {
      return false;
    }
  }
}
