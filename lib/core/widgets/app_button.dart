import 'package:flutter/material.dart';

/// A custom button widget that supports various styles,
/// loading states, and icon alignments.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.label,
    this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.icon,
    this.iconAlignment = MainAxisAlignment.center,
    this.elevation,
    this.isOutlined = false,
    this.loading = false,
    this.isDisabled = false,
    this.expanded = false,
    this.rounded = false,
  });

  /// The text label for the button.
  final String? label;

  /// The callback to be executed when the button is pressed.
  final VoidCallback? onPressed;

  /// The background color of the button.
  /// Defaults to `Theme.of(context).colorScheme.primary`.
  final Color? color;

  /// The text and icon color of the button.
  final Color? textColor;

  /// The width of the button. Defaults to full width.
  final double? width;

  /// An optional icon to display in the button.
  final Widget? icon;

  /// The alignment of the icon relative to the label.
  final MainAxisAlignment iconAlignment;

  /// The elevation of the button. Ignored if `isOutlined` is true.
  final double? elevation;

  /// If true, the button will have an outlined style.
  final bool isOutlined;

  /// If true, a loading indicator is shown and the button is disabled.
  final bool loading;

  /// If true, the button is disabled.
  final bool isDisabled;

  /// If true, the button will expand to fill the available horizontal space.
  final bool expanded;

  /// If true, the button will have a rounded pill shape.
  /// If false, it will have a rectangular shape.
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = (isDisabled || loading) ? null : onPressed;
    final defaultColor = Theme.of(context).colorScheme.primary;

    final buttonContent = loading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisAlignment: iconAlignment,
            mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (icon != null && iconAlignment == MainAxisAlignment.start) ...[
                icon!,
                const SizedBox(width: 8.0),
              ],
              if (label != null)
                Text(
                  label!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              if (icon != null && iconAlignment == MainAxisAlignment.end) ...[
                const SizedBox(width: 8.0),
                icon!,
              ],
            ],
          );

    final buttonStyle = isOutlined
        ? OutlinedButton.styleFrom(
            foregroundColor: textColor,
            side: BorderSide(color: textColor ?? defaultColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(rounded ? 24.0 : 8.0),
            ),
            elevation: 0,
            minimumSize: Size(width ?? (expanded ? double.infinity : 0), 48.0),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: color ?? defaultColor,
            foregroundColor: textColor,
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(rounded ? 24.0 : 8.0),
            ),
            minimumSize: Size(width ?? (expanded ? double.infinity : 0), 48.0),
          );

    final button = isOutlined
        ? OutlinedButton(
            style: buttonStyle,
            onPressed: effectiveOnPressed,
            child: buttonContent,
          )
        : ElevatedButton(
            style: buttonStyle,
            onPressed: effectiveOnPressed,
            child: buttonContent,
          );

    return SizedBox(width: width, child: button);
  }
}
