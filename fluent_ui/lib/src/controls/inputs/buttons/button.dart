import 'package:fluent_ui/fluent_ui.dart';

/// A button gives the user a way to trigger an immediate action.
///
/// ![Button Example](https://docs.microsoft.com/en-us/windows/apps/design/controls/images/button.png)
///
/// See also:
///
///   * [ToggleButton], a button that can be on and off.
///   * [SplitButton], A button with two sides. One side initiates
///     an action, and the other side opens a menu.
///   * <https://docs.microsoft.com/en-us/windows/apps/design/controls/buttons>
class Button extends BaseButton {
  /// Creates a button.
  const Button({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool autofocus = false,
    ButtonStyle? style,
  }) : super(
          key: key,
          child: child,
          focusNode: focusNode,
          autofocus: autofocus,
          onLongPress: onLongPress,
          onPressed: onPressed,
          style: style,
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final ThemeData theme = FluentTheme.of(context);
    return ButtonStyle(
      elevation: ButtonState.resolveWith((states) {
        if (states.isPressing) return 0.0;
        return 0.3;
      }),
      shadowColor: ButtonState.all(theme.shadowColor),
      padding: ButtonState.all(const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      )),
      shape: ButtonState.all(RoundedRectangleBorder(
        side: BorderSide(
          color: theme.disabledColor.withOpacity(0.75),
          width: 0.1,
        ),
        borderRadius: BorderRadius.circular(4.0),
      )),
      backgroundColor: ButtonState.resolveWith((states) {
        return ButtonThemeData.buttonColor(theme.brightness, states);
      }),
      foregroundColor: ButtonState.resolveWith((states) {
        if (states.isDisabled) return theme.disabledColor;
        return ButtonThemeData.buttonColor(theme.brightness, states).basedOnLuminance().toAccentColor()[
            states.isPressing
                ? theme.brightness.isLight
                    ? 'lighter'
                    : 'dark'
                : 'normal'];
      }),
    );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    return ButtonTheme.of(context).defaultButtonStyle;
  }
}
