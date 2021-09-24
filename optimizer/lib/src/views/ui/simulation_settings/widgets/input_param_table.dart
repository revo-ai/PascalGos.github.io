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

  int maxParameterCount = 6;

  bool disabled = false;

  double parameterRowHeight = 30;

  TextEditingController cmFileTextController = TextEditingController();
  TextEditingController parameterKeyController = TextEditingController();
  TextEditingController boundsStartController = TextEditingController();
  TextEditingController boundsEndController = TextEditingController();

  @override
  void initState() {
    if (this.widget.parameters.length == maxParameterCount) {
      disabled = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Variation Parameter',
        style: FluentTheme.of(context).typography.title,
      ),
      SizedBox(height: 10),
      Container(
        width: 150,
        child: OutlinedButton(
          child: Row(
            children: [
              Icon(
                FluentIcons.add,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Add parameter",
              ),
            ],
          ),
          onPressed: disabled
              ? null
              : () async {
                  var result = await showDialog(
                    context: context,
                    useRootNavigator: false,
                    builder: (_) => AddInParamDialog(
                        callback: (val) => setState(() {
                              _inputParam = val;
                              this.widget.parameters.add(_inputParam);
                              if (this.widget.parameters.length ==
                                  maxParameterCount) {
                                disabled = true;
                              }
                              widget.callback(this.widget.parameters);
                            })),
                  );
                },
        ),
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
            TableCell(
                child: Container(
              child: Text(''),
            )),
            TableCell(child: Container(child: Text('Key'))),
            TableCell(child: Container(child: Text('CMFile'))),
            TableCell(child: Container(child: Text('Bounds'))),
          ]),
        ],
      ),
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
                          color: FluentTheme.of(context).accentColor),
                      children: [
                        TableCell(
                          child: Center(
                            child: Container(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    this
                                        .widget
                                        .parameters
                                        .remove(this.widget.parameters[index]);
                                    if (this.widget.parameters.length <
                                        maxParameterCount) {
                                      disabled = false;
                                    }

                                    widget.callback(this.widget.parameters);
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
                        TableCell(
                            child: GestureDetector(
                          onDoubleTap: () {
                            SideSheet.right(
                                backgroundColor:
                                    FluentTheme.of(context).micaBackgroundColor,
                                body: EditInputParamSideSheet(
                                  param: this.widget.parameters[index],
                                  callback: (val) => setState(() {
                                    _inputParam = val;
                                    this.widget.parameters[index].cm_File =
                                        _inputParam.cm_File;
                                    this.widget.parameters[index].key =
                                        _inputParam.key;
                                    this.widget.parameters[index].bounds[0] =
                                        _inputParam.bounds[0];
                                    this.widget.parameters[index].bounds[1] =
                                        _inputParam.bounds[1];
                                  }),
                                ),
                                context: context);
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: parameterRowHeight,
                              child: Text(this.widget.parameters[index].key)),
                        )),
                        TableCell(
                            child: GestureDetector(
                          onDoubleTap: () {
                            SideSheet.right(
                                backgroundColor:
                                    FluentTheme.of(context).micaBackgroundColor,
                                body: EditInputParamSideSheet(
                                  param: this.widget.parameters[index],
                                  callback: (val) => setState(() {
                                    _inputParam = val;
                                    this.widget.parameters[index].cm_File =
                                        _inputParam.cm_File;
                                    this.widget.parameters[index].key =
                                        _inputParam.key;
                                    this.widget.parameters[index].bounds[0] =
                                        _inputParam.bounds[0];
                                    this.widget.parameters[index].bounds[1] =
                                        _inputParam.bounds[1];
                                  }),
                                ),
                                context: context);
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: parameterRowHeight,
                              child:
                                  Text(this.widget.parameters[index].cm_File)),
                        )),
                        TableCell(
                            child: GestureDetector(
                          onDoubleTap: () {
                            SideSheet.right(
                                backgroundColor:
                                    FluentTheme.of(context).micaBackgroundColor,
                                body: EditInputParamSideSheet(
                                  param: this.widget.parameters[index],
                                  callback: (val) => setState(() {
                                    _inputParam = val;
                                    this.widget.parameters[index].cm_File =
                                        _inputParam.cm_File;
                                    this.widget.parameters[index].key =
                                        _inputParam.key;
                                    this.widget.parameters[index].bounds[0] =
                                        _inputParam.bounds[0];
                                    this.widget.parameters[index].bounds[1] =
                                        _inputParam.bounds[1];
                                  }),
                                ),
                                context: context);
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: parameterRowHeight,
                              child: Text(this
                                  .widget
                                  .parameters[index]
                                  .bounds
                                  .toString())),
                        )),
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
                              setState(() {
                                this
                                    .widget
                                    .parameters
                                    .remove(this.widget.parameters[index]);
                                if (this.widget.parameters.length <
                                    maxParameterCount) {
                                  disabled = false;
                                }
                                widget.callback(this.widget.parameters);
                              });
                            },
                            icon: Icon(FluentIcons.delete, size: 14.0),
                            style: ButtonStyle(
                              shape: ButtonState.resolveWith((states) {
                                if (ButtonStates.values
                                    .contains(ButtonStates.hovering)) {
                                  return CircleBorder(
                                      side: BorderSide(
                                          color: Colors.transparent, width: 1));
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
                    TableCell(
                        child: GestureDetector(
                      onDoubleTap: () {
                        SideSheet.right(
                            backgroundColor:
                                FluentTheme.of(context).micaBackgroundColor,
                            body: EditInputParamSideSheet(
                              param: this.widget.parameters[index],
                              callback: (val) => setState(() {
                                _inputParam = val;
                                this.widget.parameters[index].cm_File =
                                    _inputParam.cm_File;
                                this.widget.parameters[index].key =
                                    _inputParam.key;
                                this.widget.parameters[index].bounds[0] =
                                    _inputParam.bounds[0];
                                this.widget.parameters[index].bounds[1] =
                                    _inputParam.bounds[1];
                              }),
                            ),
                            context: context);
                      },
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: parameterRowHeight,
                          child: Text(this.widget.parameters[index].key)),
                    )),
                    TableCell(
                        child: GestureDetector(
                      onDoubleTap: () {
                        SideSheet.right(
                            backgroundColor:
                                FluentTheme.of(context).micaBackgroundColor,
                            body: EditInputParamSideSheet(
                              param: this.widget.parameters[index],
                              callback: (val) => setState(() {
                                _inputParam = val;
                                this.widget.parameters[index].cm_File =
                                    _inputParam.cm_File;
                                this.widget.parameters[index].key =
                                    _inputParam.key;
                                this.widget.parameters[index].bounds[0] =
                                    _inputParam.bounds[0];
                                this.widget.parameters[index].bounds[1] =
                                    _inputParam.bounds[1];
                              }),
                            ),
                            context: context);
                      },
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: parameterRowHeight,
                          child: Text(this.widget.parameters[index].cm_File)),
                    )),
                    TableCell(
                        child: GestureDetector(
                      onDoubleTap: () {
                        SideSheet.right(
                            backgroundColor:
                                FluentTheme.of(context).micaBackgroundColor,
                            body: EditInputParamSideSheet(
                              param: this.widget.parameters[index],
                              callback: (val) => setState(() {
                                _inputParam = val;
                                this.widget.parameters[index].cm_File =
                                    _inputParam.cm_File;
                                this.widget.parameters[index].key =
                                    _inputParam.key;
                                this.widget.parameters[index].bounds[0] =
                                    _inputParam.bounds[0];
                                this.widget.parameters[index].bounds[1] =
                                    _inputParam.bounds[1];
                              }),
                            ),
                            context: context);
                      },
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: parameterRowHeight,
                          child: Text(
                              this.widget.parameters[index].bounds.toString())),
                    )),
                  ]),
                ],
              ),
            );
          }),
      Center(
        child: Text(
          this.widget.parameters.length.toString() +
              ' of ' +
              maxParameterCount.toString(),
          style: FluentTheme.of(context).typography.caption,
        ),
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
      return Center(
          heightFactor: 6.0,
          child: Text("- Your parameter list is empty - ",
              style: FluentTheme.of(context).typography.subtitle));
    } else
      return Container();
  }
}
