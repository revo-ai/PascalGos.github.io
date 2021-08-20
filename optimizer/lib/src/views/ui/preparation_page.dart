import 'package:flutter/material.dart' as material;
import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:optimizer/src/core/models/simulation_settings_model.dart';
import 'package:optimizer/src/core/services/download_service.dart';
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
  // CMConfig _cmConfig =
  //     CMConfig(cmPath: "", cmProj: "", cmTestrun: "", tarQuantity: "");
  CMConfig _cmConfig = CMConfig(
    cmPath: "C:/IPG/.../bin/CM.exe",
    cmProj: "C:/CM_Projects/CM10",
    cmTestrun: "Braking",
  );
  bool _cmConfigIsSelected = false;
  List<InputParameter> _inputParameters = [];
  List<TargetParameter> _targetParameters = [];
  int _iterations = 0;
  int _time = 0;
  bool _isSimulationRun = true;
  set cmConfig(CMConfig value) => setState(() => _cmConfig = value);
  set cmConfigIsSelected(bool value) =>
      setState(() => _cmConfigIsSelected = value);
  set inputParameters(List<InputParameter> value) =>
      setState(() => _inputParameters = value);
  set targetParameters(List<TargetParameter> value) =>
      setState(() => _targetParameters = value);

  final FlyoutController flyoutController = FlyoutController();
  TextEditingController simulationParameterController = TextEditingController();

  String simulationTextPlaceholder = "Set Run-Time";

  String errorCMConfig = "";
  String errorInputParameters = "";
  String errorTargetParameters = "";
  String errorSimulationParameters = "";

  @override
  void dispose() {
    // flyoutController.dispose();
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget swapWidget = FilledButton(
      style: ButtonStyle(
        shape: ButtonState.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
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
          builder: (_) => AddCMConfigDialog(
            callback: (val) => setState(() => _cmConfig = val),
            isChecked: (val) => setState(() => _cmConfigIsSelected = val),
          ),
        );
      },
    );

    if (_cmConfigIsSelected) {
      swapWidget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black,
        ),
        // style: ButtonStyle(
        //     shape: ButtonState.all(
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        //     backgroundColor: ButtonState.all(Colors.black)),
        child: Row(
          children: [
            //TODO: Change Color for FluentIcons
            Expanded(
                flex: 1,
                child: Icon(FluentIcons.accept_medium, color: Colors.white)),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Text(
                  "CM-File: " +
                      _cmConfig.cmPath +
                      "\nProject: " +
                      _cmConfig.cmProj +
                      "\nTestrun: " +
                      _cmConfig.cmTestrun,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: Icon(FluentIcons.delete, color: Colors.white),
                  onPressed: () {
                    _cmConfig = CMConfig(
                      cmPath: "",
                      cmProj: "",
                      cmTestrun: "",
                    );

                    setState(() {
                      _cmConfigIsSelected = false;
                    });
                  }),
            )
          ],
        ),
      );
    }
    return ScaffoldPage(
      header: PageHeader(
        title: Text(
          'Preparation',
          style: FluentTheme.of(context).typography.header,
        ),
        commandBar: SizedBox(
          height: 50.0,
          child: SplitButtonBar(buttons: [
            FilledButton(
              style: ButtonStyle(
                shape: ButtonState.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
              ),
              child: Text("Run"),
              onPressed: () {
                setState(() {
                  errorCMConfig = validateCMConfig(_cmConfigIsSelected);
                  errorInputParameters =
                      validateInputParameter(_inputParameters);
                  errorTargetParameters =
                      validateTargetParameter(_targetParameters);
                  errorSimulationParameters = validateSimulationParameters(
                      simulationParameterController.text);
                });

                if (validateForm(errorCMConfig, errorInputParameters,
                    errorTargetParameters, errorSimulationParameters)) {
                  if (_isSimulationRun) {
                    _time = int.parse(simulationParameterController.text);
                  } else {
                    _iterations = int.parse(simulationParameterController.text);
                  }
                  SimulationSettings sim = new SimulationSettings(
                      cmConfig: _cmConfig,
                      inputParams: _inputParameters,
                      targetParams: _targetParameters,
                      optConfig: OPTConfig(
                          algos: Algos(
                            boGpLibVersion: true,
                            boRFLibVersion: false,
                            cmaEs: false,
                            customBo: false,
                            deOptimizer: false,
                            randomOPT: false,
                          ),
                          iterations: _iterations,
                          time: _time));
                  print(sim.toJson().toString());
                  Navigator.pushNamed(context, 'generation');
                }
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
                onPressed: () {
                  setState(() {
                    errorCMConfig = validateCMConfig(_cmConfigIsSelected);
                    errorInputParameters =
                        validateInputParameter(_inputParameters);
                    errorTargetParameters =
                        validateTargetParameter(_targetParameters);
                    errorSimulationParameters = validateSimulationParameters(
                        simulationParameterController.text);
                  });

                  if (validateForm(errorCMConfig, errorInputParameters,
                      errorTargetParameters, errorSimulationParameters)) {
                    if (_isSimulationRun) {
                      _time = int.parse(simulationParameterController.text);
                    } else {
                      _iterations =
                          int.parse(simulationParameterController.text);
                    }
                    SimulationSettings sim = new SimulationSettings(
                        cmConfig: _cmConfig,
                        inputParams: _inputParameters,
                        targetParams: _targetParameters,
                        optConfig: OPTConfig(
                            algos: Algos(
                              boGpLibVersion: true,
                              boRFLibVersion: false,
                              cmaEs: false,
                              customBo: false,
                              deOptimizer: false,
                              randomOPT: false,
                            ),
                            iterations: _iterations,
                            time: _time));

                    DownloadService.saveStringAsJson(sim.toJson().toString());
                  }
                }),
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
          children: <Widget>[
            Text(
              'Starting Point',
              style: FluentTheme.of(context).typography.subheader,
            ),
            SizedBox(height: 10),
            Text(
                "Choose a default starting point as the basis of the simulation",
                style: FluentTheme.of(context).typography.body),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: swapWidget,
                ),
                Spacer(flex: 2),
              ],
            ),
            Text(
              errorCMConfig,
              style: TextStyle(
                color: Colors.errorPrimaryColor,
                fontSize: FluentTheme.of(context).typography.caption!.fontSize,
                fontWeight:
                    FluentTheme.of(context).typography.caption!.fontWeight,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Parameters',
              style: FluentTheme.of(context).typography.subheader,
            ),
            SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Input Parameter',
                      style: FluentTheme.of(context).typography.subtitle,
                    ),
                    Text(
                      errorInputParameters,
                      style: TextStyle(
                        color: Colors.errorPrimaryColor,
                        fontSize: FluentTheme.of(context)
                            .typography
                            .caption!
                            .fontSize,
                        fontWeight: FluentTheme.of(context)
                            .typography
                            .caption!
                            .fontWeight,
                      ),
                    ),
                    SizedBox(height: 10),
                    InputParamTable(
                        parameters: _inputParameters,
                        callback: (val) =>
                            setState(() => _inputParameters = val)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Target Parameter',
                      style: FluentTheme.of(context).typography.subtitle,
                    ),
                    Text(
                      errorTargetParameters,
                      style: TextStyle(
                        color: Colors.errorPrimaryColor,
                        fontSize: FluentTheme.of(context)
                            .typography
                            .caption!
                            .fontSize,
                        fontWeight: FluentTheme.of(context)
                            .typography
                            .caption!
                            .fontWeight,
                      ),
                    ),
                    SizedBox(height: 10),
                    TargetParamTable(
                        parameters: _targetParameters,
                        callback: (val) =>
                            setState(() => _targetParameters = val)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Spacer(),
            ]),
            // Expanded(
            //   child: Row(children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           SizedBox(height: 50),
            //           Text('Algorithms',
            //               style: FluentTheme.of(context).typography.subheader),
            //           SizedBox(height: 10),
            //           Text(
            //             'DEOptimizer',
            //             style: FluentTheme.of(context).typography.subtitle,
            //           ),
            //           Text(
            //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque finibus lacinia. Fusce leo justo, vestibulum ornare congue at, placerat et libero.',
            //             style: FluentTheme.of(context).typography.body,
            //           ),
            //           SizedBox(height: 10),
            //           Row(
            //             children: [
            //               ToggleSwitch(
            //                 checked: _isSimulationRun,
            //                 onChanged: (value) =>
            //                     setState(() => _isSimulationRun = value),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(_isSimulationRun.toString()),
            //             ],
            //           ),
            //           SizedBox(height: 20),
            //           Text(
            //             'bo_rf_lib_version',
            //             style: FluentTheme.of(context).typography.subtitle,
            //           ),
            //           Text(
            //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque finibus lacinia. Fusce leo justo, vestibulum ornare congue at, placerat et libero.',
            //             style: FluentTheme.of(context).typography.body,
            //           ),
            //           SizedBox(height: 10),
            //           Row(
            //             children: [
            //               ToggleSwitch(
            //                 checked: _isSimulationRun,
            //                 onChanged: (value) =>
            //                     setState(() => _isSimulationRun = value),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(_isSimulationRun.toString()),
            //             ],
            //           ),
            //           SizedBox(height: 20),
            //           Text(
            //             'random_opt',
            //             style: FluentTheme.of(context).typography.subtitle,
            //           ),
            //           Text(
            //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque finibus lacinia. Fusce leo justo, vestibulum ornare congue at, placerat et libero.',
            //             style: FluentTheme.of(context).typography.body,
            //           ),
            //           SizedBox(height: 10),
            //           Row(
            //             children: [
            //               ToggleSwitch(
            //                 checked: _isSimulationRun,
            //                 onChanged: (value) =>
            //                     setState(() => _isSimulationRun = value),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(_isSimulationRun.toString()),
            //             ],
            //           ),
            //           SizedBox(height: 20),
            //           Text(
            //             'bo_gp_lib_version',
            //             style: FluentTheme.of(context).typography.subtitle,
            //           ),
            //           Text(
            //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque finibus lacinia. Fusce leo justo, vestibulum ornare congue at, placerat et libero.',
            //             style: FluentTheme.of(context).typography.body,
            //           ),
            //           SizedBox(height: 10),
            //           Row(
            //             children: [
            //               ToggleSwitch(
            //                 checked: _isSimulationRun,
            //                 onChanged: (value) =>
            //                     setState(() => _isSimulationRun = value),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(_isSimulationRun.toString()),
            //             ],
            //           ),
            //           SizedBox(height: 20),
            //           Text(
            //             'custom_bo',
            //             style: FluentTheme.of(context).typography.subtitle,
            //           ),
            //           Text(
            //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque finibus lacinia. Fusce leo justo, vestibulum ornare congue at, placerat et libero.',
            //             style: FluentTheme.of(context).typography.body,
            //           ),
            //           SizedBox(height: 10),
            //           Row(
            //             children: [
            //               ToggleSwitch(
            //                 checked: _isSimulationRun,
            //                 onChanged: (value) =>
            //                     setState(() => _isSimulationRun = value),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(_isSimulationRun.toString()),
            //             ],
            //           ),
            //           SizedBox(height: 20),
            //           Text(
            //             'CMA-ES',
            //             style: FluentTheme.of(context).typography.subtitle,
            //           ),
            //           Text(
            //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque finibus lacinia. Fusce leo justo, vestibulum ornare congue at, placerat et libero.',
            //             style: FluentTheme.of(context).typography.body,
            //           ),
            //           SizedBox(height: 10),
            //           Row(
            //             children: [
            //               ToggleSwitch(
            //                 checked: _isSimulationRun,
            //                 onChanged: (value) =>
            //                     setState(() => _isSimulationRun = value),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(_isSimulationRun.toString()),
            //             ],
            //           ),
            //           SizedBox(height: 20),
            //           SizedBox(
            //             height: 10,
            //           ),
            //         ],
            //       ),
            //     ),
            //     Spacer(),
            //   ]),
            // ),
            Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'Simulation Parameters',
                      style: FluentTheme.of(context).typography.subheader,
                    ),
                    SizedBox(height: 10),
                    Row(children: [
                      RadioButton(
                        checked: _isSimulationRun,
                        onChanged: (value) {
                          setState(() {
                            _isSimulationRun ^= true;
                            if (_isSimulationRun) {
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
                        checked: !_isSimulationRun,
                        onChanged: (value) {
                          setState(() {
                            _isSimulationRun ^= true;
                            if (!_isSimulationRun) {
                              simulationTextPlaceholder = "Set simulation-runs";
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
                            controller: simulationParameterController,
                            // suffixMode: OverlayVisibilityMode.always,
                            // suffix: IconButton(
                            //     icon: Icon(FluentIcons.search),
                            //     onPressed: () => print("Button clicked")),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Text(
                      errorSimulationParameters,
                      style: TextStyle(
                        color: Colors.errorPrimaryColor,
                        fontSize: FluentTheme.of(context)
                            .typography
                            .caption!
                            .fontSize,
                        fontWeight: FluentTheme.of(context)
                            .typography
                            .caption!
                            .fontWeight,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
              Spacer(),
            ]),
          ]),

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
    );
  }

  String validateCMConfig(bool isSelected) {
    if (!isSelected) {
      return "Please provide the CarMaker Configuration";
    } else
      return "";
  }

  String validateInputParameter(List<InputParameter> params) {
    if (params.length == 0) {
      return "Please provide at least 1 Input Parameter";
    } else
      return "";
  }

  String validateTargetParameter(List<TargetParameter> params) {
    if (params.length == 0) {
      return "Please provide at least 1 Target Parameter";
    } else
      return "";
  }

  String validateSimulationParameters(String value) {
    if (value == "") {
      return "Please provide a value";
    } else if (double.tryParse(value) == null) {
      return "Please use a numeric value";
    } else
      return "";
  }

  bool validateForm(
    String value1,
    String value2,
    String value3,
    String value4,
  ) {
    if (value1 == "" && value2 == "" && value3 == "") {
      return true;
    } else {
      return false;
    }
  }
}
