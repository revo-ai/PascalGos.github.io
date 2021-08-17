import 'package:example/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hovering/hovering.dart';

import 'add_tarparam_dialog.dart';

class TargetParamTable extends StatefulWidget {
  const TargetParamTable({Key? key}) : super(key: key);

  @override
  _TargetParamTableState createState() => _TargetParamTableState();
}

class _TargetParamTableState extends State<TargetParamTable> {
  List<String> litems = [
    "vParameter",
    "vParameter2",
    "vParameter3",
    "vParameter"
  ];
  List<String> lbounds = ["[0,5]", "[2,5]", "[2,5]", "[4,5]"];
  double parameterRowHeight = 30;

  List<Parameter> parameters = [];

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

  TextEditingController cmFileTextController = TextEditingController();
  TextEditingController parameterKeyController = TextEditingController();
  TextEditingController boundsStartController = TextEditingController();
  TextEditingController boundsEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Table(
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(4),
        },
        border: TableBorder(
            bottom: BorderSide(
                width: 1.5, color: Colors.black, style: BorderStyle.solid)),
        children: [
          TableRow(children: [
            TableCell(child: Container(child: Text(''))),
            TableCell(child: Container(child: Text('Key'))),
            TableCell(child: Container(child: Text('Optimization Criteria'))),
          ]),
        ],
      ),
      Container(
        constraints: BoxConstraints(
            minHeight: parameterRowHeight, maxHeight: parameterRowHeight * 6),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: parameters.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return HoverWidget(
                hoverChild: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(6),
                    2: FlexColumnWidth(3),
                  },
                  border: TableBorder(
                      bottom: BorderSide(
                          width: 1,
                          color: Colors.grey,
                          style: BorderStyle.solid)),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                        decoration:
                            BoxDecoration(color: Colors.successSecondaryColor),
                        children: [
                          TableCell(
                            child: Center(
                              child: Container(
                                child: IconButton(
                                  onPressed: () {
                                    print("IconButton pressed!");
                                    setState(() {
                                      parameters.remove(parameters[index]);
                                    });
                                  },
                                  icon: Icon(FluentIcons.delete, size: 14.0),
                                  style: ButtonStyle(
                                    shape: ButtonState.resolveWith((states) {
                                      if (ButtonStates.values
                                          .contains(ButtonStates.hovering)) {
                                        return CircleBorder(
                                            side: BorderSide(
                                                color: Colors.black, width: 1));
                                      }
                                    }),
                                    foregroundColor:
                                        ButtonState.resolveWith((states) {
                                      if (ButtonStates.values
                                          .contains(ButtonStates.hovering)) {
                                        return Colors.black;
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
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: parameterRowHeight,
                                  child: Text(parameters[index].key))),
                          TableCell(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: parameterRowHeight,
                                  child: Text(
                                      parameters[index].bounds.toString()))),
                        ]),
                  ],
                ),
                onHover: (event) {},
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(6),
                    2: FlexColumnWidth(3),
                  },
                  border: TableBorder(
                      bottom: BorderSide(
                          width: 1,
                          color: Colors.grey,
                          style: BorderStyle.solid)),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Container(
                            child: IconButton(
                              onPressed: () {
                                print("IconButton pressed!");
                                setState(() {
                                  parameters.remove(parameters[index]);
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
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: parameterRowHeight,
                              child: Text(parameters[index].key))),
                      TableCell(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: parameterRowHeight,
                              child:
                                  Text(parameters[index].bounds.toString()))),
                    ]),
                  ],
                ),
              );
            }),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
            child: FilledButton(
              child: Row(
                children: [
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
                print("Add parameter pressed");
                var result = await showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (_) => AddTarParamDialog(),
                ).then((value) {
                  if (value != null && value is Parameter) {
                    setState(() {
                      parameters.add(value);
                    });
                  }
                });
              },
            ),
          ),
        ],
      ),
    ]);
  } // build

}
