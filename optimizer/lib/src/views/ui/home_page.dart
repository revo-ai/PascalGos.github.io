import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:optimizer/src/core/models/parameter_model.dart';
import 'package:optimizer/src/core/models/simulation_settings_model.dart';
import 'package:optimizer/src/views/ui/configuration_Selection/configuration_selection_page.dart';
import 'package:optimizer/src/views/ui/result_page.dart';
import 'package:optimizer/src/views/ui/colors.dart';
import 'package:optimizer/src/views/ui/forms.dart';
import 'package:optimizer/src/views/ui/mobile.dart';
import 'package:optimizer/src/views/ui/others.dart';
import 'package:optimizer/src/views/ui/simulation_settings/simulation_settings_page.dart';
import 'package:optimizer/src/views/ui/settings.dart';
import 'package:optimizer/src/views/ui/simulation_page.dart';
import 'package:optimizer/src/views/ui/typography.dart';
import 'package:optimizer/src/views/ui/welcome_page.dart';
import 'package:optimizer/src/views/utils/theme.dart';
import 'package:optimizer/src/views/utils/window_buttons.dart';
import 'package:optimizer/src/views/ui/inputs.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter/foundation.dart';

const String appTitle = 'Revo.AI Flutter Showcase ';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  bool simSettingsSet = false;

  late SimulationSettings simulationSettings;

  final colorsController = ScrollController();
  final settingsController = ScrollController();

  @override
  void dispose() {
    colorsController.dispose();
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
      // appBar: NavigationAppBar(
      //   // height: !kIsWeb ? appWindow.titleBarHeight : 31.0,
      //   title: () {
      //     if (kIsWeb) return Text(appTitle);
      //     return MoveWindow(
      //       child: Align(
      //         alignment: Alignment.centerLeft,
      //         child: Text(appTitle),
      //       ),
      //     );
      //   }(),
      //   actions: kIsWeb
      //       ? null
      //       : MoveWindow(
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [Spacer(), WindowButtons()],
      //           ),
      //         ),
      // ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(children: [
            Container(
                child: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: FluentTheme.of(context).brightness.isLight
                  ? Image.asset(
                      'assets/revoAI_logo_white.png',
                      color: Color.fromARGB(255, 0, 0, 0),
                      height: 120,
                      width: 120,
                      fit: BoxFit.fitWidth,
                    )
                  : Image.asset(
                      'assets/revoAI_logo_white.png',
                      color: Color.fromARGB(255, 255, 255, 255),
                      //color: Color.fromARGB(255, 36, 47, 94),
                      height: 120,
                      width: 120,
                      fit: BoxFit.fitWidth,
                    ),
            )),
            Text(
              "Explorer",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            )
          ]),
        ),
        displayMode: appTheme.displayMode,
        indicatorBuilder: ({
          required BuildContext context,
          int? index,
          required List<Offset> Function() offsets,
          required List<Size> Function() sizes,
          required Axis axis,
          required Widget child,
        }) {
          if (index == null) return child;
          assert(debugCheckHasFluentTheme(context));
          final theme = NavigationPaneTheme.of(context);
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return EndNavigationIndicator(
                index: index,
                offsets: offsets,
                sizes: sizes,
                child: child,
                color: theme.highlightColor,
                curve: theme.animationCurve ?? Curves.linear,
                axis: axis,
              );
            case NavigationIndicators.sticky:
              return NavigationPane.defaultNavigationIndicator(
                index: index,
                context: context,
                offsets: offsets,
                sizes: sizes,
                axis: axis,
                child: child,
              );
            default:
              return NavigationIndicator(
                index: index,
                offsets: offsets,
                sizes: sizes,
                child: child,
                color: theme.highlightColor,
                curve: theme.animationCurve ?? Curves.linear,
                axis: axis,
              );
          }
        },
        items: [
          PaneItemHeader(
            header: Text(
              "Actions",
            ),
          ),
          PaneItem(
            icon: Icon(
              FluentIcons.home,
            ),
            title: Text(
              'Home',
            ),
          ),
          PaneItem(
            icon: Icon(
              FluentIcons.edit_note,
            ),
            title: Text(
              'New Scenario',
            ),
          ),
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
              icon: Icon(
                FluentIcons.settings,
              ),
              title: Text(
                'Settings',
              )),
        ],
      ),
      content: NavigationBody(index: index, children: [
        Navigator(
          onGenerateRoute: (settings) {
            Widget page = WelcomePage(
              indexCallback: (val) {
                setState(() {
                  index = val;
                });
              },
              simSetCallback: (hasSimSet, simSet) {
                setState(() {
                  simSettingsSet = hasSimSet;
                  simulationSettings = simSet;
                  index = 1;
                });
              },
            );

            // Widget page = SimulationsSettingsPage(
            //   simulationSettings: SimulationSettings(
            //     cmConfig: CMConfig(
            //       cmPath: "Test",
            //     ),
            //     inputParams: [
            //       InputParameter(
            //           key: "Test", bounds: [0, 2], cm_File: "cm_File"),
            //     ],
            //     targetParams: [
            //       TargetParameter(
            //         key: "Test",
            //         operation: Operation(
            //           key: "max",
            //           bounds: [0, 2],
            //         ),
            //       ),
            //     ],
            //     optConfig: OPTConfig(),
            //   ),
            // );

            return FluentPageRoute(builder: (_) => page);
          },
        ),
        Navigator(
          onGenerateRoute: (settings) {
            Widget page = ConfigurationSelection();
            if (simSettingsSet) {
              simSettingsSet = false;
              page = SimulationsSettingsPage(
                  simulationSettings: simulationSettings);
            }
            return FluentPageRoute(builder: (_) => page);
          },
        ),
        SettingsPage(controller: settingsController),
      ]),
    );
  }
}
