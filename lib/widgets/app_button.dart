import 'package:flutter/material.dart';

///виджет кнопки
class AppButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final double borderRadius;
  final EdgeInsets padding;
  final double fontSize;
  final Color color;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
    this.fontSize = 26.0,
    required this.color,
    this.fullWidth = true
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget button = ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius))),
            padding: MaterialStateProperty.all<EdgeInsets>(padding),
            backgroundColor: MaterialStateColor.resolveWith((states) => theme.colorScheme.onBackground)
        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize: fontSize,
              color: color,
          ),
        )
    );

    if(!fullWidth) return button;
    return SizedBox(
      width: double.infinity,
      child: button,
    );
  }
}