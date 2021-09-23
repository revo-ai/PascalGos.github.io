import 'package:fluent_ui/fluent_ui.dart';

typedef void SimulationValueCallback(bool hasDuration, int value);

class SimulationParamCommandBar extends StatefulWidget {
  final SimulationValueCallback callback;
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
  int _iterations = 100;
  int _duration = 3;

  @override
  void initState() {
    iterationController.text = _iterations.toString();
    durationController.text = _duration.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  try {
                    _duration = int.parse(value);
                  } catch (e) {
                    print(" " + e.toString());
                  }

                  this.widget.callback(_hasDuration, _duration);
                });
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
                setState(() {
                  try {
                    _iterations = int.parse(value);
                  } catch (e) {
                    print(" " + e.toString());
                  }
                  this.widget.callback(_hasDuration, _iterations);
                });
              },
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
