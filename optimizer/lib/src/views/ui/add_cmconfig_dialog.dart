import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/core/models/simulation_settings_model.dart';

typedef void CMConfigCallback(CMConfig cmConfig);
typedef void CheckCallback(bool isTrue);

class AddCMConfigDialog extends StatefulWidget {
  final CMConfigCallback callback;
  final CheckCallback isChecked;
  const AddCMConfigDialog(
      {Key? key, required this.callback, required this.isChecked})
      : super(key: key);
  @override
  _AddCMConfigDialogState createState() => new _AddCMConfigDialogState();
}

class _AddCMConfigDialogState extends State<AddCMConfigDialog> {
  TextEditingController cmPathTextController = TextEditingController();
  TextEditingController cmProjPathTextController = TextEditingController();
  TextEditingController cmTestrunTextController = TextEditingController();

  String errorCarMakerFile = "";
  String errorCarMakerProjectFile = "";
  String errorCarMakerTestRunFile = "";

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Default Starting Point'),
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
                header: 'Select Car Maker File',
                placeholder: 'Select *',
                controller: cmPathTextController,
                readOnly: true,
                maxLines: 1,
                suffixMode: OverlayVisibilityMode.always,
                suffix: IconButton(
                    icon: Icon(FluentIcons.upload),
                    onPressed: () async {
                      print("Button clicked");
                      var picked = await FilePicker.platform.pickFiles();
                      if (picked != null) {
                        cmPathTextController.text = picked.files.first.name;
                      }
                    })),
            Text(
              errorCarMakerFile,
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
              header: 'Select Car Maker Project File',
              placeholder: 'Select *',
              controller: cmProjPathTextController,
              readOnly: true,
              maxLines: 1,
              suffixMode: OverlayVisibilityMode.always,
              suffix: IconButton(
                  icon: Icon(FluentIcons.upload),
                  onPressed: () async {
                    print("Button clicked");
                    var picked = await FilePicker.platform.pickFiles();
                    if (picked != null) {
                      cmProjPathTextController.text = picked.files.first.name;
                    }
                  }),
            ),
            Text(
              errorCarMakerProjectFile,
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
              header: 'Select CM-Testrun-File',
              placeholder: '...',
              controller: cmTestrunTextController,
              maxLines: 1,
            ),
            Text(
              errorCarMakerTestRunFile,
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
            SizedBox(
              height: 10,
            ),
          ]),
      actions: [
        Button(
          child: Text('Add'),
          onPressed: () {
            setState(() {
              errorCarMakerFile = validateCarMakerFile(
                cmPathTextController.text,
              );
              errorCarMakerProjectFile =
                  validateCarMakerTestRunFile(cmProjPathTextController.text);
              errorCarMakerTestRunFile =
                  validateCarMakerProjectFile(cmTestrunTextController.text);
            });

            if (validateForm(errorCarMakerFile, errorCarMakerProjectFile,
                errorCarMakerTestRunFile)) {
              CMConfig _cmConfig = CMConfig(
                cmPath: cmPathTextController.text,
                cmProj: cmProjPathTextController.text,
                cmTestrun: cmTestrunTextController.text,
              );
              this.widget.callback(_cmConfig);
              this.widget.isChecked(true);
              Navigator.pop(context);
            }
          },
        ),
        Button(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  String validateCarMakerFile(String value) {
    if (value == "") {
      return "Please provide a file";
    } else
      return "";
  }

  String validateCarMakerProjectFile(String value) {
    if (value == "") {
      return "Please provide a file";
    } else
      return "";
  }

  String validateCarMakerTestRunFile(String value) {
    if (value == "") {
      return "Please provide a filename";
    } else
      return "";
  }

  String validateTarQuantity(String value) {
    if (value == "") {
      return "Please provide a target quantity";
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
