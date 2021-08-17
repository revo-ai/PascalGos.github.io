import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hovering/hovering.dart';

class InputParamTable extends StatefulWidget {
  const InputParamTable({Key? key}) : super(key: key);

  @override
  _InputParamTableState createState() => _InputParamTableState();
}

class _InputParamTableState extends State<InputParamTable> {
  List<String> litems = [
    "vParameter",
    "vParameter2",
    "vParameter3",
    "vParameter"
  ];
  List<String> lbounds = ["[0,5]", "[2,5]", "[2,5]", "[4,5]"];
  double parameterRowHeight = 30;

  List<Parameter> parameters = [];

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
          1: FlexColumnWidth(6),
          2: FlexColumnWidth(3),
        },
        border: TableBorder(
            bottom: BorderSide(
                width: 1.5, color: Colors.black, style: BorderStyle.solid)),
        children: [
          TableRow(children: [
            TableCell(child: Container(child: Text(''))),
            TableCell(child: Container(child: Text('Key'))),
            TableCell(child: Container(child: Text('Bounds'))),
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
              onPressed: () {
                print("Add parameter pressed");
                showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (_) => ContentDialog(
                    title: Text('Add new parameter'),
                    content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                          SizedBox(
                            height: 10,
                          ),
                          TextBox(
                            header: 'Enter Parameter Key',
                            placeholder: 'Type here...',
                            controller: parameterKeyController,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Bounds"),
                          Row(
                            children: [
                              Expanded(
                                child: TextBox(
                                  placeholder: 'Type here...',
                                  controller: boundsStartController,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextBox(
                                  placeholder: 'Type here...',
                                  controller: boundsEndController,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          )
                        ]),
                    actions: [
                      Button(
                        child: Text('Add'),
                        onPressed: () {
                          setState(() {
                            if (parameters.length < 6) {
                              parameters.add(Parameter(
                                key: parameterKeyController.text,
                                bounds: [
                                  double.parse(boundsStartController.text),
                                  double.parse(boundsEndController.text)
                                ],
                                cm_File: cmFileTextController.text,
                                //TODO: iterate index
                                val_index: 3,
                              ));
                              // TODO: Set State, when come back
                              Navigator.of(context).pop();
                            }
                          });
                        },
                      ),
                      Button(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ]);
  } // build

}
