import 'package:fluent_ui/fluent_ui.dart';

class SimulationParamCommandBar extends StatefulWidget {
  const SimulationParamCommandBar({Key? key}) : super(key: key);

  @override
  _SimulationParamCommandBar createState() => _SimulationParamCommandBar();
}

class _SimulationParamCommandBar extends State<SimulationParamCommandBar> {
  int _iterations = 0;
  int _time = 0;
  bool _hasDuration = true;
  bool _hasIterations = false;
  String simulationTextPlaceholder = "Set Run-Time";
  String errorSimulationParameters = "";
  TextEditingController durationController = TextEditingController();
  TextEditingController iterationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    iterationController.text = '100';
    durationController.text = '3:00';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RadioButton(
            checked: _hasDuration,
            onChanged: (value) {
              setState(() {
                _hasDuration ^= true;
                _hasIterations ^= true;
              });
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 120),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (_hasIterations) {
                  _hasDuration = true;
                  _hasIterations = false;
                }
              });
            },
            child: TextBox(
              enabled: _hasDuration,
              readOnly: !_hasDuration,
              enableInteractiveSelection: !_hasDuration,
              outsidePrefix: Text("Duration: "),
              outsideSuffix: Text(' h'),
              maxLines: 1,
              keyboardType: TextInputType.number,
              controller: durationController,
            ),
          ),
        ),
        SizedBox(width: 10),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: RadioButton(
            checked: !_hasDuration,
            onChanged: (value) {
              setState(() {
                _hasDuration ^= true;
                _hasIterations ^= true;
              });
            },
          ),
        ),
        SizedBox(width: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 120),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (_hasDuration) {
                  _hasDuration = false;
                  _hasIterations = true;
                }
                if (_hasDuration) _hasIterations = true;
              });
            },
            child: TextBox(
              enabled: !_hasDuration,
              readOnly: _hasDuration,
              enableInteractiveSelection: _hasDuration,
              outsidePrefix: Text("Iterations: "),
              maxLines: 1,
              keyboardType: TextInputType.number,
              controller: iterationController,
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
