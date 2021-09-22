import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/views/ui/widgets/side_sheet.dart';

class EditConfigSideSheet extends StatefulWidget {
  const EditConfigSideSheet({
    Key? key,
  }) : super(key: key);

  @override
  _EditConfigSideSheetState createState() => _EditConfigSideSheetState();
}

class _EditConfigSideSheetState extends State<EditConfigSideSheet> {
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
                ),
                SizedBox(
                  height: 10,
                ),
                TextBox(
                    header: 'Select CARLA-Application File',
                    placeholder: 'Select *.exe',
                    // controller: cmPathTextController,
                    readOnly: true,
                    maxLines: 1,
                    suffixMode: OverlayVisibilityMode.always,
                    suffix: IconButton(
                        icon: Icon(FluentIcons.upload),
                        onPressed: () async {
                          var picked = await FilePicker.platform.pickFiles();
                          if (picked != null) {
                            // cmPathTextController.text =
                            //     picked.files.first.name;
                          }
                        })),
                Text(
                  '',
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
                  // controller: cmProjPathTextController,
                  readOnly: true,
                  maxLines: 1,
                  suffixMode: OverlayVisibilityMode.always,
                  suffix: IconButton(
                      icon: Icon(FluentIcons.upload),
                      onPressed: () async {
                        var picked = await FilePicker.platform.pickFiles();
                        if (picked != null) {
                          // cmProjPathTextController.text =
                          //     picked.files.first.name;
                        }
                      }),
                ),
                Text(
                  '',
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
                ),
                Text(
                  '',
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
                    onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
