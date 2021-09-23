//import 'package:flutter/material.dart' as material;
import 'package:file_picker/file_picker.dart';
import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:optimizer/src/core/models/simulation_settings_model.dart';
import 'package:optimizer/src/core/services/download_service.dart';
import 'package:optimizer/src/views/ui/simulation_settings/widgets/input_param_table.dart';
import 'package:optimizer/src/views/ui/result_page.dart';
import 'package:optimizer/src/views/ui/simulation_settings/widgets/simulation_param_commandbar.dart';
import 'package:optimizer/src/views/ui/simulation_settings/widgets/start_configuration_container.dart';
import 'package:optimizer/src/views/ui/simulation_settings/widgets/target_param_table.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../simulation_page.dart';

const Widget spacer = const SizedBox(height: 5.0);

const double iconSize = 40;

class SimulationsSettingsPage extends StatefulWidget {
  final SimulationSettings simulationSettings;
  const SimulationsSettingsPage({
    Key? key,
    required this.simulationSettings,
  }) : super(key: key);

  @override
  _SimulationsSettingsPageState createState() =>
      _SimulationsSettingsPageState();
}

class _SimulationsSettingsPageState extends State<SimulationsSettingsPage> {
  final FlyoutController flyoutController = FlyoutController();
  final ScrollController scrollController = ScrollController();

  String errorCMConfig = "";
  String errorInputParameters = "";
  String errorTargetParameters = "";

  bool _isDuration = true;
  int _time = 3;
  int _iterations = 100;

  @override
  void dispose() {
    // flyoutController.dispose();
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CMConfig _cmConfig = this.widget.simulationSettings.cmConfig;

    return ScaffoldPage(
      header: PageHeader(
        title: Text(
          'Parameter Settings',
          style: FluentTheme.of(context).typography.titleLarge,
        ),
        commandBar: Row(
          children: [
            SimulationParamCommandBar(
              callback: (val, bool) {
                setState(() {
                  _isDuration = bool;
                  if (_isDuration) {
                    _time = val;
                  } else {
                    _iterations = val;
                  }
                });
              },
            ),
            SplitButtonBar(
              style: SplitButtonThemeData(
                primaryButtonStyle: ButtonStyle(),
                interval: 2,
                borderRadius: BorderRadius.circular(4),
              ),
              buttons: [
                FilledButton(
                  child: Text("Run"),
                  onPressed: () {
                    setState(() {
                      errorInputParameters = validateInputParameter(
                          this.widget.simulationSettings.inputParams);
                      errorTargetParameters = validateTargetParameter(
                          this.widget.simulationSettings.targetParams);
                    });

                    if (validateForm(
                      errorCMConfig,
                      errorInputParameters,
                      errorTargetParameters,
                    )) {
                      if (_isDuration) {
                        _iterations = 0;
                      } else {
                        _time = 0;
                      }
                      this.widget.simulationSettings.optConfig.iterations =
                          _iterations;
                      this.widget.simulationSettings.optConfig.time = _time;
                      print(this.widget.simulationSettings.toJson().toString());
                      Navigator.push(
                        context,
                        FluentPageRoute(builder: (context) {
                          return SimulationPage(
                            simulationSettings: this.widget.simulationSettings,
                          );
                        }),
                      );
                    }
                  },
                ),
                Button(
                  child: Text("Save Settings"),
                  onPressed: () {
                    setState(() {
                      // errorCMConfig = validateCMConfig(_cmConfigIsSelected);
                      errorInputParameters = validateInputParameter(
                          this.widget.simulationSettings.inputParams);
                      errorTargetParameters = validateTargetParameter(
                          this.widget.simulationSettings.targetParams);
                    });

                    if (validateForm(errorCMConfig, errorInputParameters,
                        errorTargetParameters)) {
                      if (_isDuration) {
                        _iterations = 0;
                      } else {
                        _time = 0;
                      }
                      this.widget.simulationSettings.optConfig.iterations =
                          _iterations;
                      this.widget.simulationSettings.optConfig.time = _time;
                      DownloadService.saveStringAsJson(
                          this.widget.simulationSettings.toJson().toString());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      content: Scrollbar(
        controller: scrollController,
        child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: PageHeader.horizontalPadding(context),
            ),
            children: <Widget>[
              Wrap(
                spacing: 50,
                runSpacing: 50,
                children: [
                  MediaQuery.of(context).size.width < 1350
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: StartConfigurationContainer(
                            cmConfig: _cmConfig,
                            callback: (val) => _cmConfig = val,
                          ),
                        )
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.35,
                          ),
                          child: StartConfigurationContainer(
                            cmConfig: _cmConfig,
                            callback: (val) => _cmConfig = val,
                          ),
                        ),
                ],
              ),
              SizedBox(height: 40),
              Wrap(
                spacing: 50,
                runSpacing: 50,
                children: [
                  MediaQuery.of(context).size.width < 1350
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: InputParamTable(
                              parameters:
                                  this.widget.simulationSettings.inputParams,
                              callback: (val) => setState(() => this
                                  .widget
                                  .simulationSettings
                                  .inputParams = val)),
                        )
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.35,
                          ),
                          child: InputParamTable(
                              parameters:
                                  this.widget.simulationSettings.inputParams,
                              callback: (val) => setState(() => this
                                  .widget
                                  .simulationSettings
                                  .inputParams = val)),
                        ),
                  MediaQuery.of(context).size.width < 1350
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: TargetParamTable(
                              parameters:
                                  this.widget.simulationSettings.targetParams,
                              callback: (val) => setState(() => this
                                  .widget
                                  .simulationSettings
                                  .targetParams = val)),
                        )
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.35,
                          ),
                          child: TargetParamTable(
                              parameters:
                                  this.widget.simulationSettings.targetParams,
                              callback: (val) => setState(() => this
                                  .widget
                                  .simulationSettings
                                  .targetParams = val)),
                        ),
                ],
              ),
              Divider(),
            ]),
      ),
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
  ) {
    if (value1 == "" && value2 == "" && value3 == "") {
      return true;
    } else {
      return false;
    }
  }
}
