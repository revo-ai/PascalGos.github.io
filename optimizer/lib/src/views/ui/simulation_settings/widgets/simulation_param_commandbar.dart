import 'package:fluent_ui/fluent_ui.dart';

typedef void SimulationParameterCallback(String value, bool isDuration);

class SimulationParamCommandBar extends StatefulWidget {
  final SimulationParameterCallback callback;
  const SimulationParamCommandBar({Key? key, required this.callback})
      : super(key: key);

  @override
  _SimulationParamCommandBar createState() => _SimulationParamCommandBar();
}

class _SimulationParamCommandBar extends State<SimulationParamCommandBar> {
  bool _hasDuration = true;
  bool _hasIterations = false;
  String simulationTextPlaceholder = "Set Run-Time";
  String errorSimulationParameters = "";
  TextEditingController durationController = TextEditingController();
  TextEditingController iterationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    iterationController.text = '100';
    durationController.text = '3';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: RadioButton(
            checked: _hasDuration,
            onChanged: (value) {
              setState(() {
                _hasDuration = true;
                _hasIterations = false;
              });
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 110,
          ),
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
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              controller: durationController,
              onChanged: (value) {
                this.widget.callback(value, _hasDuration);
              },
            ),
          ),
        ),
        SizedBox(width: 10),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: RadioButton(
            checked: !_hasDuration,
            onChanged: (value) {
              setState(() {
                _hasDuration = false;
                _hasIterations = true;
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
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              controller: iterationController,
              onChanged: (value) {
                this.widget.callback(value, _hasDuration);
              },
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
