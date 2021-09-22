import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hovering/hovering.dart';
import 'package:optimizer/src/views/ui/simulation_settings/widgets/edit_inparam_sidesheet.dart';
import 'package:optimizer/src/views/ui/widgets/side_sheet.dart';

import 'add_inparam_dialog.dart';

typedef void ParameterCallback(List<InputParameter> params);

class InputParamTable extends StatefulWidget {
  final ParameterCallback callback;
  final List<InputParameter> parameters;
  const InputParamTable(
      {Key? key, required this.parameters, required this.callback})
      : super(key: key);

  @override
  _InputParamTableState createState() => _InputParamTableState();
}

class _InputParamTableState extends State<InputParamTable> {
  late InputParameter _inputParam;
  set targetParameter(InputParameter value) =>
      setState(() => _inputParam = value);

  double parameterRowHeight = 30;

  TextEditingController cmFileTextController = TextEditingController();
  TextEditingController parameterKeyController = TextEditingController();
  TextEditingController boundsStartController = TextEditingController();
  TextEditingController boundsEndController = TextEditingController();

  String errorCMFile = "";
  String errorParameterKey = "";
  String errorBounds = "";
  String errorInputParameters = "";

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Variation Parameter',
        style: FluentTheme.of(context).typography.title,
      ),
      Text(
        errorInputParameters,
        style: TextStyle(
          color: Colors.errorPrimaryColor,
          fontSize: FluentTheme.of(context).typography.caption!.fontSize,
          fontWeight: FluentTheme.of(context).typography.caption!.fontWeight,
        ),
      ),
      SizedBox(height: 10),
      Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 200,
            ),
            child: Expanded(
              child: FilledButton(
                style: ButtonStyle(
                  shape: ButtonState.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
                ),
                child: Row(
                  children: [
                    //TODO: Make Color to Theme color
                    Icon(FluentIcons.add, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Add parameter",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
                onPressed: () async {
                  if (this.widget.parameters.length < 6) {
                    var result = await showDialog(
                      context: context,
                      useRootNavigator: false,
                      builder: (_) => AddInParamDialog(
                          callback: (val) => setState(() => _inputParam = val)),
                    ).then((_) {
                      if (_inputParam != null &&
                          _inputParam is InputParameter) {
                        setState(() {
                          this.widget.parameters.add(_inputParam);
                          widget.callback(this.widget.parameters);
                        });
                      }
                    });
                  }
                },
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Table(
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(6),
          2: FlexColumnWidth(3),
          3: FlexColumnWidth(3),
        },
        border: TableBorder(
            bottom: BorderSide(
                width: 1.5,
                color: FluentTheme.of(context).inactiveColor,
                style: BorderStyle.solid)),
        children: [
          TableRow(children: [
            TableCell(child: Container(child: Text(''))),
            TableCell(child: Container(child: Text('Key'))),
            TableCell(child: Container(child: Text('CMFile'))),
            TableCell(child: Container(child: Text('Bounds'))),
          ]),
        ],
      ),
      Container(
        constraints: BoxConstraints(
            minHeight: parameterRowHeight, maxHeight: parameterRowHeight * 6),
        child: Column(children: [
          EmptyParameterListReminder(
              paramListIsEmpty: this.widget.parameters.isEmpty),
          ListView.builder(
              shrinkWrap: true,
              itemCount: this.widget.parameters.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return HoverWidget(
                  hoverChild: Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(6),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                    },
                    border: TableBorder(
                        bottom: BorderSide(
                            width: 1,
                            color: FluentTheme.of(context).inactiveColor,
                            style: BorderStyle.solid)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                              color: Colors.successSecondaryColor),
                          children: [
                            TableCell(
                              child: Center(
                                child: Container(
                                  child: IconButton(
                                    onPressed: () {
                                      print("IconButton pressed!");
                                      widget.callback(this.widget.parameters);
                                      setState(() {
                                        this.widget.parameters.remove(
                                            this.widget.parameters[index]);
                                      });
                                    },
                                    icon: Icon(FluentIcons.delete, size: 14.0),
                                    style: ButtonStyle(
                                      shape: ButtonState.resolveWith((states) {
                                        if (ButtonStates.values
                                            .contains(ButtonStates.hovering)) {
                                          return CircleBorder(
                                              side: BorderSide(
                                                  color: FluentTheme.of(context)
                                                      .inactiveColor,
                                                  width: 1));
                                        }
                                      }),
                                      foregroundColor:
                                          ButtonState.resolveWith((states) {
                                        if (ButtonStates.values
                                            .contains(ButtonStates.hovering)) {
                                          return FluentTheme.of(context)
                                              .inactiveColor;
                                        }
                                        if (ButtonStates.values
                                            .contains(ButtonStates.none)) {
                                          return Colors.transparent;
                                        }
                                        if (ButtonStates.values
                                            .contains(ButtonStates.pressing)) {
                                          return Colors.warningPrimaryColor;
                                        }
                                      }),
                                      backgroundColor:
                                          ButtonState.resolveWith((states) {
                                        if (ButtonStates.values
                                            .contains(ButtonStates.hovering)) {
                                          return Colors.transparent;
                                        }
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onDoubleTap: () {
                                SideSheet.right(
                                    body: EditInputParamSideSheet(),
                                    context: context);
                              },
                              child: TableCell(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: parameterRowHeight,
                                      child: Text(
                                          this.widget.parameters[index].key))),
                            ),
                            GestureDetector(
                              onDoubleTap: () {
                                SideSheet.right(
                                    body: EditInputParamSideSheet(),
                                    context: context);
                              },
                              child: TableCell(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: parameterRowHeight,
                                      child: Text(this
                                          .widget
                                          .parameters[index]
                                          .cm_File))),
                            ),
                            GestureDetector(
                              onDoubleTap: () {
                                SideSheet.right(
                                    body: EditInputParamSideSheet(),
                                    context: context);
                              },
                              child: TableCell(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: parameterRowHeight,
                                      child: Text(this
                                          .widget
                                          .parameters[index]
                                          .bounds
                                          .toString()))),
                            ),
                          ]),
                    ],
                  ),
                  onHover: (event) {},
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(6),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                    },
                    border: TableBorder(
                        bottom: BorderSide(
                            width: 1,
                            color: FluentTheme.of(context).inactiveColor,
                            style: BorderStyle.solid)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Center(
                            child: Container(
                              child: IconButton(
                                onPressed: () {
                                  widget.callback(this.widget.parameters);
                                  print("IconButton pressed!");
                                  setState(() {
                                    this
                                        .widget
                                        .parameters
                                        .remove(this.widget.parameters[index]);
                                  });
                                },
                                icon: Icon(FluentIcons.delete, size: 14.0),
                                style: ButtonStyle(
                                  shape: ButtonState.resolveWith((states) {
                                    if (ButtonStates.values
                                        .contains(ButtonStates.hovering)) {
                                      return CircleBorder(
                                          side: BorderSide(
                                              color: Colors.transparent,
                                              width: 1));
                                    }
                                  }),
                                  foregroundColor:
                                      ButtonState.resolveWith((states) {
                                    if (ButtonStates.values
                                        .contains(ButtonStates.hovering)) {
                                      return Colors.transparent;
                                    }
                                    if (ButtonStates.values
                                        .contains(ButtonStates.none)) {
                                      return Colors.transparent;
                                    }
                                    if (ButtonStates.values
                                        .contains(ButtonStates.pressing)) {
                                      return Colors.warningPrimaryColor;
                                    }
                                  }),
                                  backgroundColor:
                                      ButtonState.resolveWith((states) {
                                    if (ButtonStates.values
                                        .contains(ButtonStates.hovering)) {
                                      return Colors.transparent;
                                    }
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            SideSheet.right(
                                body: EditInputParamSideSheet(),
                                context: context);
                          },
                          child: TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: parameterRowHeight,
                                  child:
                                      Text(this.widget.parameters[index].key))),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            SideSheet.right(
                                body: EditInputParamSideSheet(),
                                context: context);
                          },
                          child: TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: parameterRowHeight,
                                  child: Text(
                                      this.widget.parameters[index].cm_File))),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            SideSheet.right(
                                body: EditInputParamSideSheet(),
                                context: context);
                          },
                          child: TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: parameterRowHeight,
                                  child: Text(this
                                      .widget
                                      .parameters[index]
                                      .bounds
                                      .toString()))),
                        ),
                      ]),
                    ],
                  ),
                );
              }),
        ]),
      ),
    ]);
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
    } else if (double.tryParse(value1) != null ||
        double.tryParse(value2) != null) {
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

  // build

}

class EmptyParameterListReminder extends StatefulWidget {
  final bool paramListIsEmpty;
  const EmptyParameterListReminder({Key? key, required this.paramListIsEmpty})
      : super(key: key);

  @override
  EmptyParameterListReminderState createState() =>
      EmptyParameterListReminderState();
}

class EmptyParameterListReminderState
    extends State<EmptyParameterListReminder> {
  @override
  Widget build(BuildContext context) {
    if (widget.paramListIsEmpty) {
      return Expanded(
        child: Center(
            heightFactor: 6.0,
            child: Text("- Your parameter list is empty - ",
                style: FluentTheme.of(context).typography.subtitle)),
      );
    } else
      return Container();
  }
}
