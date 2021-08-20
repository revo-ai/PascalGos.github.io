import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';

typedef void ParameterCallback(InputParameter inputParam);

class AddInParamDialog extends StatefulWidget {
  final ParameterCallback callback;
  const AddInParamDialog({Key? key, required this.callback}) : super(key: key);

  @override
  _AddInParamDialogState createState() => new _AddInParamDialogState();
}

class _AddInParamDialogState extends State<AddInParamDialog> {
  TextEditingController cmFileTextController = TextEditingController();
  TextEditingController parameterKeyController = TextEditingController();
  TextEditingController boundsStartController = TextEditingController();
  TextEditingController boundsEndController = TextEditingController();

  String errorCMFile = "";
  String errorParameterKey = "";
  String errorBounds = "";

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Add new parameter'),
      content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please enter the relevant information',
            ),
            SizedBox(
              height: 10,
            ),
            TextBox(
              header: 'Enter CM-File',
              placeholder: 'Type here...',
              controller: cmFileTextController,
              maxLines: 1,
            ),
            Text(
              errorCMFile,
              style: TextStyle(
                color: Colors.errorPrimaryColor,
                fontSize: FluentTheme.of(context).typography.caption!.fontSize,
                fontWeight:
                    FluentTheme.of(context).typography.caption!.fontWeight,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextBox(
              header: 'Enter Parameter Key',
              placeholder: 'Type here...',
              controller: parameterKeyController,
              maxLines: 1,
            ),
            Text(
              errorParameterKey,
              style: TextStyle(
                color: Colors.errorPrimaryColor,
                fontSize: FluentTheme.of(context).typography.caption!.fontSize,
                fontWeight:
                    FluentTheme.of(context).typography.caption!.fontWeight,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Bounds"),
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    placeholder: '0',
                    controller: boundsStartController,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextBox(
                    placeholder: 'infty',
                    controller: boundsEndController,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
            Text(
              errorBounds,
              style: TextStyle(
                color: Colors.errorPrimaryColor,
                fontSize: FluentTheme.of(context).typography.caption!.fontSize,
                fontWeight:
                    FluentTheme.of(context).typography.caption!.fontWeight,
              ),
            ),
          ]),
      actions: [
        Button(
          child: Text('Add'),
          onPressed: () {
            setState(() {
              errorCMFile = validateCMFile(cmFileTextController.text);
              errorParameterKey =
                  validateParameterKey(parameterKeyController.text);
              errorBounds = validateBounds(
                  boundsStartController.text, boundsEndController.text);

              if (validateForm(errorCMFile, errorParameterKey, errorBounds)) {
                InputParameter _inputParam = InputParameter(
                  key: parameterKeyController.text,
                  bounds: [
                    double.tryParse(boundsStartController.text),
                    double.tryParse(boundsEndController.text)
                  ],
                  cm_File: cmFileTextController.text,
                );

                widget.callback(_inputParam);
                Navigator.of(context).pop();
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

  String validateCMFile(String value) {
    if (value == "") {
      return "Please provide a filename";
    } else
      return "";
  }

  String validateParameterKey(String value) {
    if (value == "") {
      return "Please provide a file";
    } else
      return "";
  }

  String validateBounds(String value1, String value2) {
    if ((value1 == "") || (value2 == "")) {
      return "Please provide both bounds";
    } else if (double.tryParse(value1) == null ||
        double.tryParse(value2) == null) {
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
