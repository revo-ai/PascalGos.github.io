import 'package:file_picker/file_picker.dart';
import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AddCMConfigDialog extends StatefulWidget {
  @override
  _AddCMConfigDialogState createState() => new _AddCMConfigDialogState();
}

class _AddCMConfigDialogState extends State<AddCMConfigDialog> {
  TextEditingController cmPathTextController = TextEditingController();
  TextEditingController cmProjPathTextController = TextEditingController();
  TextEditingController cmTestrunTextController = TextEditingController();
  TextEditingController tarQuantityTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Default Starting Point'),
      content: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
        SizedBox(
          height: 10,
        ),
        TextBox(
          header: 'Enter CM-File',
          placeholder: '...',
          controller: cmTestrunTextController,
          maxLines: 1,
        ),
        SizedBox(
          height: 10,
        ),
        TextBox(
          header: 'Enter TARQUANTITY',
          placeholder: '...',
          controller: tarQuantityTextController,
          maxLines: 1,
        ),
        SizedBox(
          height: 10,
        ),
      ]),
      actions: [
        Button(
          child: Text('Add'),
          onPressed: () {},
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
