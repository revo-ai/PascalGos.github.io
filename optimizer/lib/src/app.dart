import 'package:optimizer/src/views/ui/home_page.dart';
import 'package:optimizer/src/views/ui/preparation_page.dart';
import 'package:optimizer/src/views/ui/settings.dart';
import 'package:optimizer/src/views/ui/result_page.dart';
import 'package:optimizer/src/views/utils/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:provider/provider.dart';

const String appTitle = 'Fluent UI Showcase for Flutter';

late bool darkMode;

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            material.DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultFluentLocalizations.delegate,
          ],
          title: appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (_) => HomePage(),
            'preparation': (_) => PreparationPage(),
            'settings': (_) => SettingsPage(),
          },
          theme: ThemeData(
            accentColor: appTheme.accColor,
            // activeColor: appTheme.actColor,
            // inactiveColor: appTheme.inactColor,
            // inactiveBackgroundColor: appTheme.inactBgColor,
            // disabledColor: appTheme.disabledColor,
            // shadowColor: appTheme.shadowColor,
            // scaffoldBackgroundColor: appTheme.scaffBgColor,
            // acrylicBackgroundColor: appTheme.acrylicBgColor,
            // micaBackgroundColor: appTheme.mica_bg_color,
            brightness: appTheme.mode == ThemeMode.system
                ? darkMode
                    ? Brightness.dark
                    : Brightness.light
                : appTheme.mode == ThemeMode.dark
                    ? Brightness.dark
                    : Brightness.light,
            visualDensity: VisualDensity.standard,
            fontFamily: appTheme.fontFamily,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
        );
      },
    );
  }
}
