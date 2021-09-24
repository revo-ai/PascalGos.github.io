import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:optimizer/src/core/models/simulation_settings_model.dart';
import 'package:optimizer/src/views/ui/configuration_Selection/configuration_selection_page.dart';

import 'simulation_settings/simulation_settings_page.dart';

class ResultPage extends StatefulWidget {
  final SimulationSettings simulationSettings;
  const ResultPage({
    Key? key,
    required this.simulationSettings,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool disabled = false;

  bool value = false;

  double sliderValue = 5;
  double get max => 9;

  final FlyoutController controller = FlyoutController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
          title: Text('Results'),
        ),
        content: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: PageHeader.horizontalPadding(context),
            ),
            children: [
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            "  100%",
                            style: FluentTheme.of(context).typography.subtitle,
                          )),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(300)),
                          )),
                      SizedBox(height: 10),
                      Text(
                        'Simulation is completed!',
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
                                value: 100,
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
                        'Simulation has finished!',
                        style: FluentTheme.of(context).typography.body,
                      ),
                    ]),
              ),
              SizedBox(
                height: 50,
              ),
              // ignore: prefer_const_constructors
              Divider(
                direction: Axis.horizontal,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Export',
                            style: FluentTheme.of(context).typography.subtitle,
                          ),
                          SizedBox(height: 20),
                          TextBox(
                            header: 'Export simulation results',
                            placeholder: 'Select *',
                            maxLines: 1,
                            suffixMode: OverlayVisibilityMode.always,
                            suffix: IconButton(
                                icon: Icon(FluentIcons.export),
                                onPressed: () => print("Button clicked")),
                          ),
                          SizedBox(height: 20),
                        ]),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                              style: ButtonStyle(
                                shape: ButtonState.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                              ),
                              child: Text(
                                "Start over",
                                style: FluentTheme.of(context).typography.body,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  FluentPageRoute(builder: (context) {
                                    return SimulationsSettingsPage(
                                      simulationSettings:
                                          this.widget.simulationSettings,
                                    );
                                  }),
                                );
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(
                              child: Text(
                                "Exit",
                                style:
                                    FluentTheme.of(context).typography.caption,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  FluentPageRoute(builder: (context) {
                                    return ConfigurationSelection();
                                  }),
                                );
                              }),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ]));
  }
}
