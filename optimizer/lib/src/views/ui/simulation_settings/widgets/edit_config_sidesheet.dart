import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/core/models/simulation_settings_model.dart';

typedef void ConfigCallback(CMConfig cmConfig);

class EditConfigSideSheet extends StatefulWidget {
  CMConfig cmconfig;
  final ConfigCallback callback;
  EditConfigSideSheet({
    Key? key,
    required this.cmconfig,
    required this.callback,
  }) : super(key: key);

  @override
  _EditConfigSideSheetState createState() => _EditConfigSideSheetState();
}

class _EditConfigSideSheetState extends State<EditConfigSideSheet> {
  TextEditingController cmPathTextController = TextEditingController();
  TextEditingController cmProjPathTextController = TextEditingController();
  TextEditingController cmTestrunTextController = TextEditingController();

  String errorCarMakerFile = "";
  String errorCarMakerProjectFile = "";
  String errorCarMakerTestRunFile = "";

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

  @override
  void initState() {
    cmPathTextController.text = this.widget.cmconfig.cmPath;
    cmProjPathTextController.text = this.widget.cmconfig.cmProj;
    cmTestrunTextController.text = this.widget.cmconfig.cmTestrun;
    super.initState();
  }

  @override
  build(BuildContext context) {
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
                  'Edit Start Configuration',
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
                    header: 'Select CARLA-Application File',
                    placeholder: 'Select *.exe',
                    controller: cmPathTextController,
                    readOnly: true,
                    maxLines: 1,
                    suffixMode: OverlayVisibilityMode.always,
                    suffix: IconButton(
                        icon: Icon(FluentIcons.upload),
                        onPressed: () async {
                          var picked = await FilePicker.platform.pickFiles();
                          if (picked != null) {
                            cmPathTextController.text = picked.files.first.name;
                          }
                        })),
                Text(
                  errorCarMakerFile,
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
                  header: 'Select CARLA Project Directory',
                  placeholder: 'Select *',
                  controller: cmProjPathTextController,
                  readOnly: true,
                  maxLines: 1,
                  suffixMode: OverlayVisibilityMode.always,
                  suffix: IconButton(
                      icon: Icon(FluentIcons.upload),
                      onPressed: () async {
                        var picked = await FilePicker.platform.pickFiles();
                        if (picked != null) {
                          cmProjPathTextController.text =
                              picked.files.first.name;
                        }
                      }),
                ),
                Text(
                  errorCarMakerProjectFile,
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
                  header: 'Select CARLA-Testrun-File',
                  placeholder: '...',
                  maxLines: 1,
                  controller: cmTestrunTextController,
                ),
                Text(
                  errorCarMakerTestRunFile,
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
                      errorCarMakerFile = validateCarMakerFile(
                        cmPathTextController.text,
                      );
                      errorCarMakerProjectFile = validateCarMakerTestRunFile(
                          cmProjPathTextController.text);
                      errorCarMakerTestRunFile = validateCarMakerProjectFile(
                          cmTestrunTextController.text);
                    });

                    if (validateForm(errorCarMakerFile,
                        errorCarMakerProjectFile, errorCarMakerTestRunFile)) {
                      CMConfig _cmConfig = CMConfig(
                        cmPath: cmPathTextController.text,
                        cmProj: cmProjPathTextController.text,
                        cmTestrun: cmTestrunTextController.text,
                      );
                      this.widget.callback(_cmConfig);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
