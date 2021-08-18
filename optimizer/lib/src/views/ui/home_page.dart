import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:optimizer/src/views/ui/result_page.dart';
import 'package:optimizer/src/views/ui/colors.dart';
import 'package:optimizer/src/views/ui/forms.dart';
import 'package:optimizer/src/views/ui/mobile.dart';
import 'package:optimizer/src/views/ui/others.dart';
import 'package:optimizer/src/views/ui/preparation_page.dart';
import 'package:optimizer/src/views/ui/settings.dart';
import 'package:optimizer/src/views/ui/simulation_page.dart';
import 'package:optimizer/src/views/ui/typography.dart';
import 'package:optimizer/src/views/utils/theme.dart';
import 'package:optimizer/src/views/utils/window_buttons.dart';
import 'package:optimizer/src/views/ui/inputs.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter/foundation.dart';

const String appTitle = 'Revo.AI Flutter Showcase ';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
                child: Image.asset(
              'assets/revoAI_logo.png',
              color: Color.fromARGB(255, 36, 47, 94),
              height: 100,
              width: 100,
              //colorBlendMode: BlendMode.srcOver,
              fit: BoxFit.fitWidth,
            )),
            // FlutterLogo(
            //   style: FlutterLogoStyle.horizontal,
            //   size: 100,
            // ),
            Text(
              "Explorer",
              style: TextStyle(
                  //color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
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
              FluentIcons.edit_note,
              //color: Colors.white,
            ),
            title: Text(
              'New Scenario',
              //style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        footerItems: [
          PaneItemSeparator(
              //color: Colors.white
              ),
          PaneItem(
              icon: Icon(
                FluentIcons.settings,
                //color: Colors.white,
              ),
              title: Text(
                'Settings',
                //style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      content: NavigationBody(index: index, children: [
        Navigator(
          onGenerateRoute: (settings) {
            Widget page = PreparationPage();
            if (settings.name == 'generation') page = SimulationPage();
            if (settings.name == 'results') page = ResultPage();
            return FluentPageRoute(builder: (_) => page);
          },
        ),
        SettingsPage(controller: settingsController),
      ]),
    );
  }
}
