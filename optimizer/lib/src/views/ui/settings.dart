import 'package:flutter/foundation.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as FlutterAcrylic;
import 'package:provider/provider.dart';

import '../utils/theme.dart';

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key, this.controller}) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    final tooltipThemeData = TooltipThemeData(decoration: () {
      final radius = BorderRadius.zero;
      final shadow = [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(1, 1),
          blurRadius: 10.0,
        ),
      ];
      final border = Border.all(color: Colors.grey[100], width: 0.5);
      if (FluentTheme.of(context).brightness == Brightness.light) {
        return BoxDecoration(
          color: Colors.white,
          borderRadius: radius,
          border: border,
          boxShadow: shadow,
        );
      } else {
        return BoxDecoration(
          color: Colors.grey,
          borderRadius: radius,
          border: border,
          boxShadow: shadow,
        );
      }
    }());
    return ScaffoldPage(
      header: PageHeader(
          title: Text(
        'Settings',
        style: FluentTheme.of(context).typography.titleLarge,
      )),
      content: ListView(
        padding: EdgeInsets.only(
          bottom: kPageDefaultVerticalPadding,
          left: PageHeader.horizontalPadding(context),
          right: PageHeader.horizontalPadding(context),
        ),
        controller: controller,
        children: [
          Text('Theme mode',
              style: FluentTheme.of(context).typography.subtitle),
          ...List.generate(ThemeMode.values.length, (index) {
            final mode = ThemeMode.values[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RadioButton(
                checked: appTheme.mode == mode,
                onChanged: (value) {
                  if (value) {
                    appTheme.mode = mode;
                  }
                },
                content: Text('$mode'.replaceAll('ThemeMode.', '')),
              ),
            );
          }),
          Text(
            'Navigation Pane Display Mode',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          ...List.generate(PaneDisplayMode.values.length, (index) {
            final mode = PaneDisplayMode.values[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RadioButton(
                checked: appTheme.displayMode == mode,
                onChanged: (value) {
                  if (value) appTheme.displayMode = mode;
                },
                content: Text(
                  mode.toString().replaceAll('PaneDisplayMode.', ''),
                ),
              ),
            );
          }),
          Text('Navigation Indicator',
              style: FluentTheme.of(context).typography.subtitle),
          ...List.generate(NavigationIndicators.values.length, (index) {
            final mode = NavigationIndicators.values[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RadioButton(
                checked: appTheme.indicator == mode,
                onChanged: (value) {
                  if (value) appTheme.indicator = mode;
                },
                content: Text(
                  mode.toString().replaceAll('NavigationIndicators.', ''),
                ),
              ),
            );
          }),
          // Text('Accent Color',
          //     style: FluentTheme.of(context).typography.subtitle),
          // Wrap(children: [
          //   Tooltip(
          //     style: tooltipThemeData,
          //     child: _buildColorBlock(appTheme, systemAccentColor),
          //     message: accentColorNames[0],
          //   ),
          //   ...List.generate(Colors.accentColors.length, (index) {
          //     final color = Colors.accentColors[index];
          //     return Tooltip(
          //       style: tooltipThemeData,
          //       message: accentColorNames[index + 1],
          //       child: _buildColorBlock(appTheme, color),
          //     );
          //   }),
          // ]),
          if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) ...[
            Text('Window Transparency',
                style: FluentTheme.of(context).typography.subtitle),
            ...List.generate(FlutterAcrylic.AcrylicEffect.values.length,
                (index) {
              final mode = FlutterAcrylic.AcrylicEffect.values[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RadioButton(
                  checked: appTheme.acrylicEffect == mode,
                  onChanged: (value) {
                    if (value) {
                      appTheme.acrylicEffect = mode;
                      FlutterAcrylic.Acrylic.setEffect(
                        effect: mode,
                        gradientColor: FluentTheme.of(context)
                            .acrylicBackgroundColor
                            .withOpacity(0.2),
                      );
                    }
                  },
                  content: Text(
                    mode.toString().replaceAll('AcrylicEffect.', ''),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildColorBlock(AppTheme appTheme, AccentColor color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          appTheme.accColor = color;
        },
        style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
        child: Container(
          height: 40,
          width: 40,
          color: color,
          alignment: Alignment.center,
          child: appTheme.accColor == color
              ? Icon(
                  FluentIcons.check_mark,
                  color: color.basedOnLuminance(),
                  size: 22.0,
                )
              : null,
        ),
      ),
    );
  }
}
