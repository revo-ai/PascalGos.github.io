import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/core/models/simulation_settings_model.dart';
import 'package:optimizer/src/views/ui/widgets/side_sheet.dart';

import 'edit_config_sidesheet.dart';

class StartConfigurationContainer extends StatefulWidget {
  final CMConfig cmConfig;
  const StartConfigurationContainer({Key? key, required this.cmConfig})
      : super(key: key);

  @override
  _StartConfigurationContainerState createState() =>
      _StartConfigurationContainerState();
}

class _StartConfigurationContainerState
    extends State<StartConfigurationContainer> {
  @override
  Widget build(BuildContext context) {
    CMConfig _cmConfig = this.widget.cmConfig;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start Configuration',
          style: FluentTheme.of(context).typography.title,
        ),
        SizedBox(height: 10),
        Text(
            "Here you can see the selected startup configuration of the simulation",
            style: FluentTheme.of(context).typography.body),
        SizedBox(height: 10),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 400,
          ),
          child: GestureDetector(
            onDoubleTap: () {
              SideSheet.right(body: EditConfigSideSheet(), context: context);
            },
            child: FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                    shape: ButtonState.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                    backgroundColor: ButtonState.all(Colors.black)),
                child: Row(
                  children: [
                    Icon(FluentIcons.text_document_settings,
                        size: 30, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "CARLA.EXE: " +
                          _cmConfig.cmPath +
                          "\nProject: " +
                          _cmConfig.cmProj +
                          "\nTestrun: " +
                          _cmConfig.cmTestrun,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
