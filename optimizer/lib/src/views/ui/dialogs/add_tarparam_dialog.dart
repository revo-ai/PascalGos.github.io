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

                    print(value);
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
        )
      ]),
      actions: [
        Button(
          child: Text('Add'),
          onPressed: () {
            List bounds = [];
            switch (comboBoxValue!) {
              case 'min':
                break;
              case 'max':
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

            setState(() {
              TargetParameter tarParam = TargetParameter(
                key: parameterKeyController.text,
                operation: operation,
              );
              widget.callback(tarParam);
              Navigator.pop(context, tarParam);
              //TODO: Verify parameters maxlength
              // if (parameters.length < 6) {
              // }
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
}

class OperationInput extends StatefulWidget {
  const OperationInput({Key? key, required String value}) : super(key: key);

  @override
  _OperationInputState createState() => _OperationInputState();
}

class _OperationInputState extends State<OperationInput> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
