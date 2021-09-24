import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hovering/hovering.dart';
import 'package:optimizer/src/views/ui/widgets/side_sheet.dart';

import 'add_tarparam_dialog.dart';
import 'edit_tarparam_sidesheet.dart';
import 'input_param_table.dart';

typedef void ParameterCallback(List<TargetParameter> params);

class TargetParamTable extends StatefulWidget {
  final ParameterCallback callback;
  final List<TargetParameter> parameters;
  const TargetParamTable(
      {Key? key, required this.parameters, required this.callback})
      : super(key: key);

  @override
  _TargetParamTableState createState() => _TargetParamTableState();
}

class _TargetParamTableState extends State<TargetParamTable> {
  late TargetParameter _tarparam;
  set targetParameter(TargetParameter value) =>
      setState(() => _tarparam = value);

  bool disabled = false;

  double parameterRowHeight = 30;

  int maxParameterCount = 1;

  final values = [
    'min',
    'max',
    'equals',
    'less than',
    'less than or equal to',
    'greater than',
    'greater than or equal to'
  ];

  String? comboBoxValue;

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
        'Target Parameter',
        style: FluentTheme.of(context).typography.title,
      ),
      SizedBox(height: 10),
      Container(
        width: 150,
        child: OutlinedButton(
          style: ButtonStyle(
            shape: ButtonState.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
          ),
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
                    builder: (_) => AddTarParamDialog(
                        callback: (val) => setState(() {
                              _tarparam = val;
                              this.widget.parameters.add(_tarparam);
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
            TableCell(child: Container(child: Text(''))),
            TableCell(child: Container(child: Text('Key'))),
            TableCell(child: Container(child: Text('Criteria'))),
          ]),
        ],
      ),
      Column(children: [
        EmptyParameterListReminder(
          paramListIsEmpty: this.widget.parameters.isEmpty,
        ),
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
                                      this.widget.parameters.remove(
                                          this.widget.parameters[index]);
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
                                        return Colors.red;
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
                                      backgroundColor: FluentTheme.of(context)
                                          .micaBackgroundColor,
                                      body: EditTargetParamSideSheet(
                                          param: this.widget.parameters[index],
                                          callback: (val) {
                                            setState(() {
                                              _tarparam = val;
                                              this
                                                  .widget
                                                  .parameters[index]
                                                  .key = _tarparam.key;
                                              this
                                                      .widget
                                                      .parameters[index]
                                                      .operation
                                                      .key =
                                                  _tarparam.operation.key;
                                              this
                                                      .widget
                                                      .parameters[index]
                                                      .operation
                                                      .bounds[0] =
                                                  _tarparam.operation.bounds[0];
                                              this
                                                      .widget
                                                      .parameters[index]
                                                      .operation
                                                      .bounds[1] =
                                                  _tarparam.operation.bounds[1];
                                            });
                                          }),
                                      context: context);
                                },
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: parameterRowHeight,
                                    child: Text(
                                        this.widget.parameters[index].key))),
                          ),
                          TableCell(
                            child: GestureDetector(
                                onDoubleTap: () {
                                  SideSheet.right(
                                      backgroundColor: FluentTheme.of(context)
                                          .micaBackgroundColor,
                                      body: EditTargetParamSideSheet(
                                          param: this.widget.parameters[index],
                                          callback: (val) {
                                            setState(() {
                                              _tarparam = val;
                                              this
                                                  .widget
                                                  .parameters[index]
                                                  .key = _tarparam.key;
                                              this
                                                      .widget
                                                      .parameters[index]
                                                      .operation
                                                      .key =
                                                  _tarparam.operation.key;
                                              this
                                                      .widget
                                                      .parameters[index]
                                                      .operation
                                                      .bounds[0] =
                                                  _tarparam.operation.bounds[0];
                                              this
                                                      .widget
                                                      .parameters[index]
                                                      .operation
                                                      .bounds[1] =
                                                  _tarparam.operation.bounds[1];
                                            });
                                          }),
                                      context: context);
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: parameterRowHeight,
                                  child: ((this
                                                  .widget
                                                  .parameters[index]
                                                  .operation
                                                  .key ==
                                              'max') ||
                                          (this
                                                  .widget
                                                  .parameters[index]
                                                  .operation
                                                  .key ==
                                              'min'))
                                      ? Text(this
                                          .widget
                                          .parameters[index]
                                          .operation
                                          .key)
                                      : Text(this
                                              .widget
                                              .parameters[index]
                                              .operation
                                              .key +
                                          " " +
                                          this
                                              .widget
                                              .parameters[index]
                                              .operation
                                              .bounds[0]
                                              .toString()),
                                )),
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
                      TableCell(
                        child: GestureDetector(
                            onDoubleTap: () {
                              SideSheet.right(
                                  backgroundColor: FluentTheme.of(context)
                                      .micaBackgroundColor,
                                  body: EditTargetParamSideSheet(
                                      param: this.widget.parameters[index],
                                      callback: (val) {
                                        setState(() {
                                          _tarparam = val;
                                          this.widget.parameters[index].key =
                                              _tarparam.key;
                                          this
                                              .widget
                                              .parameters[index]
                                              .operation
                                              .key = _tarparam.operation.key;
                                          this
                                                  .widget
                                                  .parameters[index]
                                                  .operation
                                                  .bounds[0] =
                                              _tarparam.operation.bounds[0];
                                          this
                                                  .widget
                                                  .parameters[index]
                                                  .operation
                                                  .bounds[1] =
                                              _tarparam.operation.bounds[1];
                                        });
                                      }),
                                  context: context);
                            },
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: parameterRowHeight,
                                child:
                                    Text(this.widget.parameters[index].key))),
                      ),
                      TableCell(
                        child: GestureDetector(
                            onDoubleTap: () {
                              SideSheet.right(
                                  backgroundColor: FluentTheme.of(context)
                                      .micaBackgroundColor,
                                  body: EditTargetParamSideSheet(
                                      param: this.widget.parameters[index],
                                      callback: (val) {
                                        setState(() {
                                          _tarparam = val;
                                          this.widget.parameters[index].key =
                                              _tarparam.key;
                                          this
                                              .widget
                                              .parameters[index]
                                              .operation
                                              .key = _tarparam.operation.key;
                                          this
                                                  .widget
                                                  .parameters[index]
                                                  .operation
                                                  .bounds[0] =
                                              _tarparam.operation.bounds[0];
                                          this
                                                  .widget
                                                  .parameters[index]
                                                  .operation
                                                  .bounds[1] =
                                              _tarparam.operation.bounds[1];
                                        });
                                      }),
                                  context: context);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: parameterRowHeight,
                              child: ((this
                                              .widget
                                              .parameters[index]
                                              .operation
                                              .key ==
                                          'max') ||
                                      (this
                                              .widget
                                              .parameters[index]
                                              .operation
                                              .key ==
                                          'min'))
                                  ? Text(this
                                      .widget
                                      .parameters[index]
                                      .operation
                                      .key)
                                  : Text(this
                                          .widget
                                          .parameters[index]
                                          .operation
                                          .key +
                                      " " +
                                      this
                                          .widget
                                          .parameters[index]
                                          .operation
                                          .bounds[0]
                                          .toString()),
                            )),
                      ),
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
      ]),
    ]);
  }
}
