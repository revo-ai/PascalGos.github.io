import 'package:fluent_ui/fluent_ui.dart';

class SimulationParamContainer extends StatefulWidget {
  const SimulationParamContainer({Key? key}) : super(key: key);

  @override
  _SimulationParamContainerState createState() =>
      _SimulationParamContainerState();
}

class _SimulationParamContainerState extends State<SimulationParamContainer> {
  int _iterations = 0;
  int _time = 0;
  bool _isSimulationRun = true;
  String simulationTextPlaceholder = "Set Run-Time";
  String errorSimulationParameters = "";
  TextEditingController simulationParameterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Simulation Parameters',
          style: FluentTheme.of(context).typography.title,
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
            fontSize: FluentTheme.of(context).typography.caption!.fontSize,
            fontWeight: FluentTheme.of(context).typography.caption!.fontWeight,
          ),
        ),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
