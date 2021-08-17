import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:optimizer/src/views/ui/input_param_table.dart';
import 'package:optimizer/src/views/ui/result_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

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

  final FlyoutController controller = FlyoutController();
  final ScrollController scrollController = ScrollController();

  TextEditingController defaultStartingPoint_txt = TextEditingController();
  TextEditingController previousSettings_txt = TextEditingController();

  bool isSimulationRun = true;
  String simulationTextPlaceholder = "Set Run-Time";

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
          title: Text('Preparation'),
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
            Row(
              children: [
                Expanded(
                  child: TextBox(
                    header: 'Select Default Starting Point',
                    placeholder: 'Select *',
                    controller: defaultStartingPoint_txt,
                    readOnly: true,
                    maxLines: 1,
                    suffixMode: OverlayVisibilityMode.always,
                    suffix: IconButton(
                        icon: Icon(FluentIcons.upload),
                        onPressed: () async {
                          print("Button clicked");
                          var picked = await FilePicker.platform.pickFiles();
                          if (picked != null) {
                            defaultStartingPoint_txt.text =
                                picked.files.first.name;
                          }
                        }),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextBox(
                    header: 'Load previous settings',
                    placeholder: 'Select *',
                    controller: previousSettings_txt,
                    readOnly: true,
                    maxLines: 1,
                    suffixMode: OverlayVisibilityMode.always,
                    suffix: IconButton(
                        icon: Icon(FluentIcons.upload),
                        onPressed: () async {
                          print("Button clicked");
                          var picked = await FilePicker.platform.pickFiles();
                          if (picked != null) {
                            previousSettings_txt.text = picked.files.first.name;
                          }
                        }),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Parameters',
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                      SizedBox(height: 10),
                      InputParamTable(),
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
                      Text(
                        'Target Function',
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextBox(
                              header: 'Select target function',
                              placeholder: 'Select *',
                              maxLines: 1,
                              suffixMode: OverlayVisibilityMode.always,
                              suffix: IconButton(
                                  icon: Icon(FluentIcons.search),
                                  onPressed: () => print("Button clicked")),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
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
                      Row(
                        children: [
                          FilledButton(
                              child: Text(
                                "Run",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                //style: FluentTheme.of(context).typography.base,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'generation');
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(
                              child: Text(
                                "Save Settings",
                                style:
                                    FluentTheme.of(context).typography.caption,
                              ),
                              onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
