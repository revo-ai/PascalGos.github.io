import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:optimizer/src/views/ui/widgets/side_sheet.dart';

typedef void ParameterCallback(TargetParameter tarParam);

class EditTargetParamSideSheet extends StatefulWidget {
  final ParameterCallback callback;
  TargetParameter param;
  EditTargetParamSideSheet(
      {Key? key, required this.callback, required this.param})
      : super(key: key);

  @override
  _EditTargetParamSideSheetState createState() =>
      _EditTargetParamSideSheetState();
}

class _EditTargetParamSideSheetState extends State<EditTargetParamSideSheet> {
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
  void initState() {
    comboBoxValue = this.widget.param.operation.key;
    switchSwapWidget(comboBoxValue!);
    super.initState();
  }

  @override
  build(BuildContext context) {
    parameterKeyController.text = this.widget.param.key;
    try {
      boundsStartController.text =
          this.widget.param.operation.bounds[0].toString();
    } catch (e) {
      print("Error with boundsStartController: " + e.toString());
    }
    try {
      boundsEndController.text =
          this.widget.param.operation.bounds[1].toString();
    } catch (e) {
      print("Error with boundsEndController: " + e.toString());
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(
                    FluentIcons.cancel,
                    size: 25,
                  ),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Target Parameter',
                  style: FluentTheme.of(context).typography.title,
                ),
                Text('Please enter the relevant information',
                    style: FluentTheme.of(context).typography.body),
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
                          onChanged: (value) {
                            switchSwapWidget(value!);
                            setState(() => comboBoxValue = value);
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
                SizedBox(height: 10),
                FilledButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FluentIcons.save,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Save',
                          style: FluentTheme.of(context).typography.bodyStrong,
                        )
                      ],
                    ),
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
                        operation =
                            Operation(key: comboBoxValue!, bounds: bounds);
                      }

                      setState(() {
                        TargetParameter _tarParam = TargetParameter(
                          key: parameterKeyController.text,
                          operation: operation,
                        );
                        print(_tarParam.toJson().toString());
                        widget.callback(_tarParam);
                        Navigator.pop(context);
                        //TODO: Verify parameters maxlength
                        // if (parameters.length < 6) {
                        // }
                      });
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  void switchSwapWidget(String value) {
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
  }
}
