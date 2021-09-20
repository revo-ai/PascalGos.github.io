import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:optimizer/src/views/ui/widgets/configuration_tile.dart';

import 'dialogs/add_cmconfig_dialog.dart';

class ConfigurationSelection extends StatefulWidget {
  const ConfigurationSelection({Key? key}) : super(key: key);

  @override
  _ConfigurationSelectionState createState() => _ConfigurationSelectionState();
}

class _ConfigurationSelectionState extends State<ConfigurationSelection> {
  final FlyoutController controller = FlyoutController();
  final ScrollController scrollController = ScrollController();

  bool disabled = false;

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  int _selectedTileIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Select Configuration'),
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
                  index: 0,
                  selectedTileIndex: _selectedTileIndex,
                  configurationName: 'CARMAKER'),
              ConfigurationTile(
                callback: (val) => setState(() => _selectedTileIndex = val),
                index: 1,
                selectedTileIndex: _selectedTileIndex,
                configurationName: 'SIMCAR',
                //disabled: true,
              ),
              ConfigurationTile(
                callback: (val) => setState(() => _selectedTileIndex = val),
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
                onPressed: disabled
                    ? null
                    : () {
                        showDialog(
                            context: context,
                            builder: (_) => _startConfigurationInput(
                                context, _selectedTileIndex));
                      },
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _startConfigurationInput(BuildContext context, int index) {
    switch (index) {
      case 0:
        return Container();
      case 1:
        return ContentDialog(
          title: Text('Configuration is not available'),
          content: Text(
            'The configuration you have chosen is not yet available.',
          ),
          actions: [
            Button(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      case 2:
        return ContentDialog(
          title: Text('Configuration is not available'),
          content: Text(
            'The configuration you have chosen is not yet available.',
          ),
          actions: [
            Button(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      default:
        return ContentDialog(
          title: Text('Something went wrong'),
          content: Text(
            'Please choose a configuration.',
          ),
          actions: [
            Button(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
    }
  }
}
