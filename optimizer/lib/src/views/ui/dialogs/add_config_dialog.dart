import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/core/models/simulation_settings_model.dart';

typedef void ConfigCallback(CMConfig cmConfig);
typedef void CheckCallback(bool isTrue);

class AddConfigDialog extends StatefulWidget {
  final ConfigCallback configCallback;
  final CheckCallback configSelectedCallBack;
  final int index;
  const AddConfigDialog(
      {Key? key,
      required this.index,
      required this.configCallback,
      required this.configSelectedCallBack})
      : super(key: key);

  @override
  _AddConfigDialogState createState() => _AddConfigDialogState();
}

class _AddConfigDialogState extends State<AddConfigDialog> {
  CMConfig _cmConfig = CMConfig(
    cmPath: "C:/IPG/.../bin/CM.exe",
    cmProj: "C:/CM_Projects/CM10",
    cmTestrun: "Braking",
  );
  bool _configIsSelected = false;

  @override
  Widget build(BuildContext context) {
    // CMDIALOG
    //###############
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

    Widget cmDialog = ContentDialog(
      title: Text('Start Configuration - CARLA'),
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
                fontSize: FluentTheme.of(context).typography.caption!.fontSize,
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
              header: 'Select CARLA-Testrun-File',
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
              this.widget.configCallback(_cmConfig);
              this.widget.configSelectedCallBack(true);
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

    Widget comingSoonDialog = ContentDialog(
      title: Text('Configuration is not available'),
      content: Text(
        'The configuration you have chosen is not yet available.',
      ),
      actions: [
        Button(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );

    Widget nothingChosenDialog = ContentDialog(
      title: Text('Something went wrong'),
      content: Text(
        'Please choose a configuration.',
      ),
      actions: [
        Button(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );

    Widget _startConfigurationDialogSwitcher(int index) {
      switch (index) {
        case 0:
          return cmDialog;
        case 1:
          return comingSoonDialog;
        case 2:
          return comingSoonDialog;
        default:
          return nothingChosenDialog;
      }
    }

    return _startConfigurationDialogSwitcher(this.widget.index);
  }
}

class AddCMConfigDialog extends StatefulWidget {
  final ConfigCallback callback;
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

class ComingSoonDialog extends StatefulWidget {
  final ConfigCallback callback;
  final CheckCallback isChecked;
  const ComingSoonDialog(
      {Key? key, required this.callback, required this.isChecked})
      : super(key: key);

  @override
  _ComingSoonDialogState createState() => _ComingSoonDialogState();
}

class _ComingSoonDialogState extends State<ComingSoonDialog> {
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Configuration is not available'),
      content: Text(
        'The configuration you have chosen is not yet available.',
      ),
      actions: [
        Button(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class NothingChosenDialog extends StatefulWidget {
  final ConfigCallback callback;
  final CheckCallback isChecked;
  const NothingChosenDialog(
      {Key? key, required this.callback, required this.isChecked})
      : super(key: key);

  @override
  _NothingChosenDialogState createState() => _NothingChosenDialogState();
}

class _NothingChosenDialogState extends State<NothingChosenDialog> {
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Something went wrong'),
      content: Text(
        'Please choose a configuration.',
      ),
      actions: [
        Button(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
