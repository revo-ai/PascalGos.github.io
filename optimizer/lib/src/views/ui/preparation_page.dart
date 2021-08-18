import 'package:flutter/material.dart' as material;
import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:optimizer/src/core/models/simulation_settings_model.dart';
import 'package:optimizer/src/views/ui/input_param_table.dart';
import 'package:optimizer/src/views/ui/result_page.dart';
import 'package:optimizer/src/views/ui/target_param_table.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'add_cmconfig_dialog.dart';

const Widget spacer = const SizedBox(height: 5.0);

const double iconSize = 40;

class PreparationPage extends StatefulWidget {
  const PreparationPage({Key? key}) : super(key: key);

  @override
  _PreparationPageState createState() => _PreparationPageState();
}

class _PreparationPageState extends State<PreparationPage> {
  bool disabled = false;
  bool value = false;
  double sliderValue = 5;
  double get max => 9;

  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  final ScrollController scrollController = ScrollController();

  final FlyoutController flyoutController = FlyoutController();

  TextEditingController defaultStartingPoint_txt = TextEditingController();
  TextEditingController previousSettings_txt = TextEditingController();

  bool isSimulationRun = true;
  String simulationTextPlaceholder = "Set Run-Time";

  @override
  void dispose() {
    // flyoutController.dispose();
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
          title: Text('Preparation'),
          commandBar: SizedBox(
            height: 50.0,
            child: SplitButtonBar(buttons: [
              FilledButton(
                style: ButtonStyle(
                  shape: ButtonState.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
                ),
                child: Text("Run"),
                // child: SizedBox(
                //   height: 50.0,
                //   child: Container(
                //     color: disabled
                //         ? FluentTheme.of(context).accentColor.darker
                //         : FluentTheme.of(context).accentColor,
                //     height: 24,
                //     width: 24,
                //   ),
                // ),
                onPressed: () {
                  List<Parameter> parameters = [];
                  parameters.add(Parameter(
                    key: "vparam1",
                    bounds: [
                      0,
                      5,
                    ],
                    cm_File: "testRun",
                    val_index: 3,
                  ));
                  SimulationSettings sim = new SimulationSettings(
                      cmConfig: CMConfig(
                          cmPath: 'test',
                          cmProj: 'Test',
                          cmTestrun: 'Test',
                          tarQuantity: 'Test'),
                      testParams: parameters,
                      optConfig: OPTConfig(
                          algos: Algos(
                            boGpLibVersion: true,
                            boRFLibVersion: true,
                            cmaEs: true,
                            customBo: true,
                            deOptimizer: true,
                            randomOPT: true,
                          ),
                          iterations: 5,
                          time: 5));
                  print(sim.toJson().toString());

                  Navigator.pushNamed(context, 'generation');
                },
              ),
              material.VerticalDivider(
                indent: 20.0,
                endIndent: 20.0,
              ),
              OutlinedButton(
                  child: Text(
                    "Save Settings",
                  ),
                  onPressed: () {}),
              // Flyout(
              //   controller: flyoutController,
              //   contentWidth: 300,
              //   verticalOffset: 20,
              //   content: Padding(
              //     padding: EdgeInsets.only(left: 27),
              //     child: FlyoutContent(
              //         padding: EdgeInsets.zero,
              //         child: ListView(
              //           shrinkWrap: true,
              //           children: [
              //             TappableListTile(
              //               title: Text("Load previous Settings"),
              //               onTap: () {},
              //             ),
              //             TappableListTile(
              //               title: Text("Save current Settings"),
              //               onTap: () {},
              //             ),
              //           ],
              //         )),
              //   ),
              //   child: Button(
              //     child: const Icon(FluentIcons.chevron_down, size: 14.0),
              //     onPressed: () => flyoutController.open = true,
              //   ),
              // ),
            ]),
          ),
        ),
        content: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: PageHeader.horizontalPadding(context),
          ),
          children: [
            Text(
              'Starting Point and Settings',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            SizedBox(height: 10),
            Text(
                "Choose a default starting point as the basis of the simulation",
                style: FluentTheme.of(context).typography.body),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: ButtonState.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                    ),
                    child: Row(
                      children: [
                        //TODO: Change Color for FluentIcons
                        Icon(FluentIcons.add_medium, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Select Default Starting Point",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                    onPressed: () async {
                      print("Select Default Starting Point pressed");
                      var result = await showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (_) => AddCMConfigDialog(),
                      ).then((value) {});
                    },
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
            SizedBox(height: 10),
            // Row(
            //   children: [
            // Expanded(
            //   child: TextBox(
            //     header: 'Select Default Starting Point',
            //     placeholder: 'Select *',
            //     controller: defaultStartingPoint_txt,
            //     readOnly: true,
            //     maxLines: 1,
            //     suffixMode: OverlayVisibilityMode.always,
            //     suffix: IconButton(
            //         icon: Icon(FluentIcons.upload),
            //         onPressed: () async {
            //           print("Button clicked");
            //           var picked = await FilePicker.platform.pickFiles();
            //           if (picked != null) {
            //             defaultStartingPoint_txt.text =
            //                 picked.files.first.name;
            //           }
            //         }),
            //   ),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: TextBox(
            //         header: 'Load previous settings',
            //         placeholder: 'Select *',
            //         controller: previousSettings_txt,
            //         readOnly: true,
            //         maxLines: 1,
            //         suffixMode: OverlayVisibilityMode.always,
            //         suffix: IconButton(
            //             icon: Icon(FluentIcons.upload),
            //             onPressed: () async {
            //               print("Button clicked");
            //               var picked = await FilePicker.platform.pickFiles();
            //               if (picked != null) {
            //                 previousSettings_txt.text = picked.files.first.name;
            //               }
            //             }),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Spacer(),
            //   ],
            // ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Input Parameter',
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                      SizedBox(height: 10),
                      InputParamTable(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Target Parameter',
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                      SizedBox(height: 10),
                      TargetParamTable(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        'Run simulation',
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                      SizedBox(height: 10),
                      Row(children: [
                        RadioButton(
                          checked: isSimulationRun,
                          onChanged: (value) {
                            setState(() {
                              isSimulationRun ^= true;
                              if (isSimulationRun) {
                                simulationTextPlaceholder = "Set Run-Time";
                              }
                            });
                          },
                          content: Text(
                            'Set run-time',
                            style: TextStyle(
                              color: FluentTheme.of(context).inactiveColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RadioButton(
                          checked: !isSimulationRun,
                          onChanged: (value) {
                            setState(() {
                              isSimulationRun ^= true;
                              if (!isSimulationRun) {
                                simulationTextPlaceholder =
                                    "Set simulation-runs";
                              }
                            });
                          },
                          content: Text(
                            'Set simulation-runs',
                            style: TextStyle(
                              color: FluentTheme.of(context).inactiveColor,
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextBox(
                              placeholder: simulationTextPlaceholder,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              // suffixMode: OverlayVisibilityMode.always,
                              // suffix: IconButton(
                              //     icon: Icon(FluentIcons.search),
                              //     onPressed: () => print("Button clicked")),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     FilledButton(
            //         style: ButtonStyle(
            //           shape: ButtonState.all(RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(4))),
            //         ),
            //         child: Text(
            //           "Run",
            //           style: TextStyle(),
            //           //style: FluentTheme.of(context).typography.base,
            //         ),
            //         onPressed: () {
            //           //TODO: Initialize/Print Settings toJSON
            //           List<Parameter> parameters = [];
            //           parameters.add(Parameter(
            //             key: "vparam1",
            //             bounds: [
            //               0,
            //               5,
            //             ],
            //             cm_File: "testRun",
            //             val_index: 3,
            //           ));
            //           SimulationSettings sim = new SimulationSettings(
            //               cmConfig: CMConfig(
            //                   cmPath: 'test',
            //                   cmProj: 'Test',
            //                   cmTestrun: 'Test',
            //                   tarQuantity: 'Test'),
            //               testParams: parameters,
            //               optConfig: OPTConfig(
            //                   algos: Algos(
            //                     boGpLibVersion: true,
            //                     boRFLibVersion: true,
            //                     cmaEs: true,
            //                     customBo: true,
            //                     deOptimizer: true,
            //                     randomOPT: true,
            //                   ),
            //                   iterations: 5,
            //                   time: 5));
            //           print(sim.toJson().toString());

            //           Navigator.pushNamed(context, 'generation');
            //         }),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     OutlinedButton(
            //         child: Text(
            //           "Save Settings",
            //           style: FluentTheme.of(context).typography.caption,
            //         ),
            //         onPressed: () {}),
            //     SizedBox(
            //       width: 100,
            //     )
            //   ],
            // ),
          ],
        ));
  }
}
