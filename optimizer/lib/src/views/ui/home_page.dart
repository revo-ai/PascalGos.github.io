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
  final int index;
  const HomePage({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool value = false;

  int index = 0;

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
                      //colorBlendMode: BlendMode.srcOver,
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
              // style: TextStyle(color: Colors.white),
            ),
          ),
          PaneItem(
            icon: Icon(
              FluentIcons.home,
              //color: Colors.white,
            ),
            title: Text(
              'Home',
              //style: TextStyle(color: Colors.white),
            ),
          ),
          PaneItem(
            icon: Icon(
              FluentIcons.edit_note,
              //color: Colors.white,
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
            Widget page = WelcomePage(indexCallback: (val) {
              setState(() {
                index = val;
              });
            });
            return FluentPageRoute(builder: (_) => page);
          },
        ),
        Navigator(
          onGenerateRoute: (settings) {
            Widget page = ConfigurationSelection();
            return FluentPageRoute(builder: (_) => page);
          },
        ),
        SettingsPage(controller: settingsController),
      ]),
    );
  }
}
