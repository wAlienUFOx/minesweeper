import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SlideButton extends StatefulWidget {

  final FormControl<int> index;
  final double fontSize;
  final Color fontColor;
  final double borderRadius;

  const SlideButton({
    required this.index,
    this.fontSize = 15,
    this.borderRadius = 10,
    required this.fontColor,
    super.key
  });

  @override
  State<SlideButton> createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(0, context),
        buildButton(1, context),
        buildButton(2, context)
      ],
    );
  }

  Widget buildButton(int buttonIndex, BuildContext context) {
    ThemeData theme = Theme.of(context);
    String textData = '';
    if (buttonIndex == 0) textData = 'Beginner';
    if (buttonIndex == 1) textData = 'Medium';
    if (buttonIndex == 2) textData = 'Expert';
    return Expanded(
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: buttonIndex == 0 ? Radius.circular(widget.borderRadius) : Radius.zero,
                    bottomLeft: buttonIndex == 0 ? Radius.circular(widget.borderRadius) : Radius.zero,
                    topRight: buttonIndex == 2 ? Radius.circular(widget.borderRadius) : Radius.zero,
                    bottomRight: buttonIndex == 2 ? Radius.circular(widget.borderRadius) : Radius.zero,
                  ),
                side: BorderSide(color: theme.colorScheme.primary)
              )),
              backgroundColor: MaterialStateColor.resolveWith((states) =>
                  theme.colorScheme.onBackground.withOpacity(buttonIndex == widget.index.value! ? 0.6 : 1.0))
          ),
          onPressed: () {
            widget.index.updateValue(buttonIndex);
            setState(() {});
          },
          child: Text(textData, style: TextStyle(color: widget.fontColor, fontSize: widget.fontSize),)
      ),
    );
  }
}
