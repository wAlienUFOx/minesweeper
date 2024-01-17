import 'package:flutter/material.dart';

class SlideButton extends StatefulWidget {

  final int pageIndex;
  final void Function(int index) callback;
  final double fontSize;
  final Color fontColor;
  final double borderRadius;

  const SlideButton({
    required this.pageIndex,
    required this.callback,
    required this.fontColor,
    this.fontSize = 15,
    this.borderRadius = 10,
    super.key
  });

  @override
  State<SlideButton> createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton> {

  //int pageIndex = 0;

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
                  theme.colorScheme.onBackground.withOpacity(buttonIndex == widget.pageIndex ? 0.6 : 1.0))
          ),
          onPressed: () => widget.callback(buttonIndex),
          child: Text(textData, style: TextStyle(color: widget.fontColor, fontSize: widget.fontSize),)
      ),
    );
  }
}
