import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:optimizer/src/core/models/simulation_settings_model.dart';
import 'package:optimizer/src/views/ui/simulation_settings/simulation_settings_page.dart';
import 'package:optimizer/src/views/ui/configuration_Selection/widgets/configuration_tile.dart';

import 'widgets/add_config_dialog.dart';

class ConfigurationSelection extends StatefulWidget {
  const ConfigurationSelection({Key? key}) : super(key: key);

  @override
  _ConfigurationSelectionState createState() => _ConfigurationSelectionState();
}

class _ConfigurationSelectionState extends State<ConfigurationSelection> {
  final FlyoutController controller = FlyoutController();
  final ScrollController scrollController = ScrollController();
  bool disabled = false;

  SimulationSettings _simulationSettings = SimulationSettings(
      cmConfig: CMConfig(),
      inputParams: [],
      targetParams: [],
      optConfig: OPTConfig());

  bool _configIsSelected = false;

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  int _selectedTileIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(
          'Select Configuration',
          style: FluentTheme.of(context).typography.titleLarge,
        ),
      ),
      content: Column(children: [
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(4),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 5,
            children: [
              ConfigurationTile(
                  callback: (val) => setState(() => _selectedTileIndex = val),
                  openConfigDialog: openConfigDialog,
                  index: 0,
                  selectedTileIndex: _selectedTileIndex,
                  configurationName: 'CARLA'),
              ConfigurationTile(
                callback: (val) => setState(() => _selectedTileIndex = val),
                openConfigDialog: openConfigDialog,
                index: 1,
                selectedTileIndex: _selectedTileIndex,
                configurationName: 'SIMCAR',
                // disabled: true,
              ),
              ConfigurationTile(
                callback: (val) => setState(() => _selectedTileIndex = val),
                openConfigDialog: openConfigDialog,
                index: 2,
                selectedTileIndex: _selectedTileIndex,
                configurationName: 'PLOTMAKER',
                //disabled: true,
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton(
                  style: ButtonStyle(
                    shape: ButtonState.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                  ),
                  child: Text("Create"),
                  onPressed: () => openConfigDialog()),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  openConfigDialog() async {
    var result = await showDialog(
        context: context,
        builder: (_) => AddConfigDialog(
              index: _selectedTileIndex,
              configCallback: (val) => _simulationSettings.cmConfig = val,
              configSelectedCallBack: (val) => _configIsSelected = val,
            )).then((value) {});

    if (_configIsSelected) {
      Navigator.push(
        context,
        FluentPageRoute(builder: (context) {
          return SimulationsSettingsPage(
            simulationSettings: _simulationSettings,
          );
        }),
      );
    }
  }
}
