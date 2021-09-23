import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:optimizer/src/core/models/simulation_settings_model.dart';
import 'package:optimizer/src/views/ui/result_page.dart';

import 'simulation_settings/simulation_settings_page.dart';

class SimulationPage extends StatefulWidget {
  final SimulationSettings simulationSettings;
  const SimulationPage({
    Key? key,
    required this.simulationSettings,
  }) : super(key: key);

  @override
  _SimulationPageState createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  late Timer timer;
  bool disabled = false;

  bool value = false;

  double sliderValue = 5;
  double get max => 9;
  double percent = 0.0;
  int index = 0;

  final FlyoutController controller = FlyoutController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  List messages = [
    "Initialise Simulation.",
    "Initialise Simulation..",
    "Initialise Simulation...",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
    "Running Test Cases.",
    "Running Test Cases..",
    "Running Test Cases...",
    "Changing Variables",
  ];

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      print("Percentage Update");
      setState(() {
        percent += 1;
        if (percent % 2 == 0) index++;
        if (percent >= 100) {
          timer.cancel();
          Navigator.push(
            context,
            FluentPageRoute(builder: (context) {
              return ResultPage(
                simulationSettings: this.widget.simulationSettings,
              );
            }),
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(messages.length);
    return ScaffoldPage(
        header: PageHeader(
          title: Text('Generation'),
        ),
        content: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: PageHeader.horizontalPadding(context),
            ),
            children: [
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: 100,
                          height: 100,
                          child: Center(
                              child: Text(
                            "  " + (percent).toString() + "%",
                            style: FluentTheme.of(context).typography.subtitle,
                          )),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: FluentTheme.of(context).inactiveColor,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(300)),
                          )),
                      SizedBox(height: 10),
                      Text(
                        'Simulation',
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: material.LinearProgressIndicator(
                                value: percent / 100,
                                minHeight: 20,
                                color: FluentTheme.of(context).accentColor,
                                backgroundColor:
                                    FluentTheme.of(context).shadowColor,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        (index < messages.length) ? messages[index] : "",
                        style: FluentTheme.of(context).typography.body,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      IconButton(
                          icon: Icon(FluentIcons.cancel),
                          onPressed: () {
                            print("IconButton pressed");
                            timer.cancel();
                            Navigator.pop(
                              context,
                              FluentPageRoute(builder: (context) {
                                return SimulationsSettingsPage(
                                  simulationSettings:
                                      this.widget.simulationSettings,
                                );
                              }),
                            );
                          })
                    ]),
              ),
            ]));
  }
}
