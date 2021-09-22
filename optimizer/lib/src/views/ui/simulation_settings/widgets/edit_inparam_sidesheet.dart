import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/views/ui/widgets/side_sheet.dart';

class EditInputParamSideSheet extends StatefulWidget {
  const EditInputParamSideSheet({
    Key? key,
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
                    onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
