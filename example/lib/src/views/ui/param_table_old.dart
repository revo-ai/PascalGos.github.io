import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class ParamTable2 extends StatefulWidget {
  const ParamTable2({Key? key}) : super(key: key);

  @override
  _ParamTable2State createState() => _ParamTable2State();
}

class _ParamTable2State extends State<ParamTable2> {
  // List<material.DataRow> _dataRows = [];
  // List<Parameter> _items = [];
  // int _sortColumnIndex = 0;
  // bool _sortAscending = true;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _items = _generateItems();
  //   });
  // }

  // List<Parameter> _generateItems() {
  //   return List.generate(5, (int index) {
  //     return Parameter(
  //       isSelected: false,
  //       key: 'v_parameter_${index + 1}',
  //       bounds: [0, 5],
  //       cm_File: 'TestRun',
  //       val_index: index + 1,
  //     );
  //   });
  // }

  // material.DataRow _createRow(Parameter param) {
  //   return material.DataRow(
  //     // index: item.id, // for DataRow.byIndex
  //     key: ValueKey(param.val_index),
  //     selected: param.isSelected,
  //     onSelectChanged: (bool? isSelected) {
  //       if (isSelected != null) {
  //         param.isSelected = isSelected;

  //         setState(() {});
  //       }
  //     },
  //     // color: material.MaterialStateColor.resolveWith(
  //     //     (Set<material.MaterialState> states) =>
  //     //         states.contains(material.MaterialState.selected)
  //     //             ? Colors.red
  //     //             : Color.fromARGB(100, 215, 217, 219)),
  //     cells: [
  //       material.DataCell(
  //   Container(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(100),
  //         border: Border.all(width: 2, color: FluentTheme.of(context).inactiveColor,)),
  //     child: IconButton(
  //       onPressed: () {
  //         print("IconButton pressed!");
  //       },
  //       icon: Icon(FluentIcons.delete, size: 14.0),
  //     ),
  //   ),
  // ),
  //       material.DataCell(
  //         Text(param.key),
  //         onTap: () {
  //           print('onTap');
  //         },
  //       ),
  //       material.DataCell(Text(
  //           param.bounds[0].toString() + '..' + param.bounds[1].toString())),
  //     ],
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return material.DataTable(
  //     dataRowHeight: 30,
  //     columnSpacing: 0,
  //     columns: _createColumns(),
  //     rows: _items.map((item) => _createRow(item)).toList(),
  //   );
  //} // build

  @override
  Widget build(BuildContext context) {
    return material.Theme(
      data: material.Theme.of(context).copyWith(
        dividerColor: FluentTheme.of(context).inactiveColor,
      ),
      child: material.DataTable(
          dataRowHeight: 30,
          columnSpacing: 0,
          columns: <material.DataColumn>[
            material.DataColumn(
              label: Text(""),
            ),
            material.DataColumn(
              label: Text(
                "Parameter",
                style: FluentTheme.of(context).typography.body,
              ),
            ),
            material.DataColumn(
              label: Text(
                "Bounds",
                style: FluentTheme.of(context).typography.body,
              ),
            ),
            material.DataColumn(
              label: Text(
                "Unit",
                style: FluentTheme.of(context).typography.body,
              ),
            ),
          ],
          rows: <material.DataRow>[
            material.DataRow(cells: <material.DataCell>[
              material.DataCell(
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: FluentTheme.of(context).inactiveColor,
                      )),
                  child: IconButton(
                    onPressed: () {
                      print("IconButton pressed!");
                    },
                    icon: Icon(FluentIcons.delete, size: 14.0),
                  ),
                ),
              ),
              material.DataCell(Text(
                "_v_Parameter",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "0..5",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "m/s",
                style: FluentTheme.of(context).typography.body,
              )),
            ]),
            material.DataRow(cells: <material.DataCell>[
              material.DataCell(
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: FluentTheme.of(context).inactiveColor,
                      )),
                  child: IconButton(
                    onPressed: () {
                      print("IconButton pressed!");
                    },
                    icon: Icon(FluentIcons.delete, size: 14.0),
                  ),
                ),
              ),
              material.DataCell(Text(
                "_v_Parameter",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "0..5",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "m/s",
                style: FluentTheme.of(context).typography.body,
              )),
            ]),
            material.DataRow(cells: <material.DataCell>[
              material.DataCell(
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: FluentTheme.of(context).inactiveColor,
                      )),
                  child: IconButton(
                    onPressed: () {
                      print("IconButton pressed!");
                    },
                    icon: Icon(FluentIcons.delete, size: 14.0),
                  ),
                ),
              ),
              material.DataCell(Text(
                "_v_Parameter",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "0..5",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "m/s",
                style: FluentTheme.of(context).typography.body,
              )),
            ]),
            material.DataRow(cells: <material.DataCell>[
              material.DataCell(
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: FluentTheme.of(context).inactiveColor,
                      )),
                  child: IconButton(
                    onPressed: () {
                      print("IconButton pressed!");
                    },
                    icon: Icon(FluentIcons.delete, size: 14.0),
                  ),
                ),
              ),
              material.DataCell(Text(
                "_v_Parameter",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "0..5",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "m/s",
                style: FluentTheme.of(context).typography.body,
              )),
            ]),
            material.DataRow(cells: <material.DataCell>[
              material.DataCell(
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: FluentTheme.of(context).inactiveColor,
                      )),
                  child: IconButton(
                    onPressed: () {
                      print("IconButton pressed!");
                    },
                    icon: Icon(FluentIcons.delete, size: 14.0),
                  ),
                ),
              ),
              material.DataCell(Text(
                "_v_Parameter",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "0..5",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "m/s",
                style: FluentTheme.of(context).typography.body,
              )),
            ]),
            material.DataRow(cells: <material.DataCell>[
              material.DataCell(
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: FluentTheme.of(context).inactiveColor,
                      )),
                  child: IconButton(
                    onPressed: () {
                      print("IconButton pressed!");
                    },
                    icon: Icon(FluentIcons.delete, size: 14.0),
                  ),
                ),
              ),
              material.DataCell(Text(
                "_v_Parameter",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "0..5",
                style: FluentTheme.of(context).typography.body,
              )),
              material.DataCell(Text(
                "m/s",
                style: FluentTheme.of(context).typography.body,
              )),
            ]),
          ]),
    );
  } // build

}
