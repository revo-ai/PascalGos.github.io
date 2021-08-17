import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class SimulationPage extends StatefulWidget {
  const SimulationPage({Key? key}) : super(key: key);

  @override
  _SimulationPageState createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  bool disabled = false;

  bool value = false;

  double sliderValue = 5;
  double get max => 9;
  double percent = 0.0;

  final FlyoutController controller = FlyoutController();
  final ScrollController scrollController = ScrollController();

  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Timer timer;
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      print("Percentage Update");
      setState(() {
        percent += 1;
        if (percent >= 100) {
          timer.cancel();
          Navigator.pushNamed(context, 'results');
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                backgroundColor:
                                    Color.fromARGB(255, 216, 216, 216),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Simulation is running...',
                        style: FluentTheme.of(context).typography.body,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      IconButton(
                          icon: Icon(FluentIcons.cancel),
                          onPressed: () {
                            print("IconButton pressed");
                            Navigator.pushNamed(context, 'preparation');
                          })
                    ]),
              ),
            ]));
  }
}
