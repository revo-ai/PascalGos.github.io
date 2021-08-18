import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as FlutterAcrylic;

enum NavigationIndicators { sticky, end }

class AppTheme extends ChangeNotifier {
  String _fontFamily = 'SegoeUI';
  String get fontFamily => _fontFamily;
  AccentColor _accColor = systemAccentColor;
  AccentColor get accColor => _accColor;
  Color _actColor = Colors.black;
  Color get actColor => _actColor;
  Color _inactColor = Colors.black;
  Color get inactColor => _inactColor;
  Color _inactBgColor = Colors.black;
  Color get inactBgColor => _inactBgColor;
  Color _disabledColor = Colors.black;
  Color get disabledColor => _disabledColor;
  Color _shadowColor = Colors.black;
  Color get shadowColor => _shadowColor;
  Color _scaffBgColor = Colors.black;
  Color get scaffBgColor => _scaffBgColor;
  Color _acrylicBgColor = Colors.black;
  Color get acrylicBgColor => _acrylicBgColor;

  Color _mica_bg_color = Color.fromARGB(255, 51, 51, 51);
  Color get mica_bg_color => _mica_bg_color;

  set accColor(AccentColor color) {
    _accColor = color;
    notifyListeners();
  }

  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  PaneDisplayMode _displayMode = PaneDisplayMode.auto;
  PaneDisplayMode get displayMode => _displayMode;
  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    notifyListeners();
  }

  NavigationIndicators _indicator = NavigationIndicators.sticky;
  NavigationIndicators get indicator => _indicator;
  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    notifyListeners();
  }

  FlutterAcrylic.AcrylicEffect _acrylicEffect =
      FlutterAcrylic.AcrylicEffect.disabled;
  FlutterAcrylic.AcrylicEffect get acrylicEffect => _acrylicEffect;
  set acrylicEffect(FlutterAcrylic.AcrylicEffect acrylicEffect) {
    _acrylicEffect = acrylicEffect;
    notifyListeners();
  }
}

AccentColor get systemAccentColor {
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb)
    return AccentColor('normal', {
      'darkest': SystemTheme.accentInstance.darkest,
      'darker': SystemTheme.accentInstance.darker,
      'dark': SystemTheme.accentInstance.dark,
      'normal': SystemTheme.accentInstance.accent,
      'light': SystemTheme.accentInstance.light,
      'lighter': SystemTheme.accentInstance.lighter,
      'lightest': SystemTheme.accentInstance.lightest,
    });
  return Colors.blue;
}
