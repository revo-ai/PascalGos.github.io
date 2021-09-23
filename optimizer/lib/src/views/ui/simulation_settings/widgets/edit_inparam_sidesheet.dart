import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:optimizer/src/views/ui/widgets/side_sheet.dart';

typedef void ParameterCallback(InputParameter inputParam);

class EditInputParamSideSheet extends StatefulWidget {
  final ParameterCallback callback;
  InputParameter param;
  EditInputParamSideSheet({
    Key? key,
    required this.param,
    required this.callback,
  }) : super(key: key);

  @override
  _EditInputParamSideSheetState createState() =>
      _EditInputParamSideSheetState();
}

class _EditInputParamSideSheetState extends State<EditInputParamSideSheet> {
  TextEditingController cmFileTextController = TextEditingController();
  TextEditingController parameterKeyController = TextEditingController();
  TextEditingController boundsStartController = TextEditingController();
  TextEditingController boundsEndController = TextEditingController();

  String errorCMFile = "";
  String errorParameterKey = "";
  String errorBounds = "";
  @override
  build(BuildContext context) {
    cmFileTextController.text = this.widget.param.cm_File;
    parameterKeyController.text = this.widget.param.key;
    boundsStartController.text = this.widget.param.bounds[0].toString();
    boundsEndController.text = this.widget.param.bounds[1].toString();

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
                  'Edit Variation Parameter',
                  style: FluentTheme.of(context).typography.title,
                ),
                Text(
                  'Please enter the relevant information',
                  style: FluentTheme.of(context).typography.body,
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
                    fontSize:
                        FluentTheme.of(context).typography.caption!.fontSize,
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
                    fontSize:
                        FluentTheme.of(context).typography.caption!.fontSize,
                    fontWeight:
                        FluentTheme.of(context).typography.caption!.fontWeight,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Bounds",
                  style: FluentTheme.of(context).typography.body,
                ),
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
                    fontSize:
                        FluentTheme.of(context).typography.caption!.fontSize,
                    fontWeight:
                        FluentTheme.of(context).typography.caption!.fontWeight,
                  ),
                ),
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
                    setState(() {
                      errorCMFile = validateCMFile(cmFileTextController.text);
                      errorParameterKey =
                          validateParameterKey(parameterKeyController.text);
                      errorBounds = validateBounds(
                          boundsStartController.text, boundsEndController.text);

                      if (validateForm(
                          errorCMFile, errorParameterKey, errorBounds)) {
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
                )
              ],
            ),
          ),
        ],
      ),
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
