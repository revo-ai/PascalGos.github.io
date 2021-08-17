import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AddTarParamDialog extends StatefulWidget {
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

  TextEditingController cmFileTextController = TextEditingController();
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
          header: 'Enter CM-File',
          placeholder: '...',
          controller: cmFileTextController,
          maxLines: 1,
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
            setState(() {
              Parameter tarParam = Parameter(
                key: parameterKeyController.text,
                bounds: [
                  double.parse(boundsStartController.text),
                  double.parse(boundsEndController.text)
                ],
                cm_File: cmFileTextController.text,
                //TODO: iterate index
                val_index: 3,
              );
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
