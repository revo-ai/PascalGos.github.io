import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/views/ui/widgets/side_sheet.dart';

class EditTargetParamSideSheet extends StatefulWidget {
  const EditTargetParamSideSheet({
    Key? key,
  }) : super(key: key);

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
                  'Edit Target Parameter',
                  style: FluentTheme.of(context).typography.title,
                ),
                Text(
                  'Please enter the relevant information',
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
                            if (value != null)
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
                    onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
