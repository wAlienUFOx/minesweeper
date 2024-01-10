import 'package:flutter/material.dart';
import 'dart:math';
import 'package:minesweeper/widgets/abstract_state.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends AbstractState<SettingsWidget> with SingleTickerProviderStateMixin {

  List<ActionButton> buttons = [
    ActionButton(
        onPressed: () => {},
        icon: const Icon(Icons.sunny)
    ),
    ActionButton(
        onPressed: () => {},
        icon: const Icon(Icons.volume_down)
    )
  ];
  late final AnimationController controller;
  late final Animation<double> expandAnimation;
  bool open = false;

  @override
  void onInitPage() {
    controller = AnimationController(
        value: 0.0,
        duration: const Duration(milliseconds: 500),
        vsync: this
    );
    expandAnimation = CurvedAnimation(
      parent: controller,
      reverseCurve: Curves.easeOutQuad,
      curve: Curves.fastOutSlowIn,
    );
    super.onInitPage();
  }

  @override
  void onDispose() {
    controller.dispose();
    super.onDispose();
  }

  void toggle() {
    open = !open;
    if (open) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          buildToClose(),
          ...buildButtons(),
          buildToOpen()
        ],
      ),
    );
  }

  Widget buildToClose() {
    return SizedBox(
      width: 60,
      height: 60,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          color: theme.colorScheme.onBackground,
          child: InkWell(
            onTap: toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: theme.colorScheme.background,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildButtons() {
    final children = <Widget>[];
    final count = buttons.length;
    const step = 75;
    for (var i = 0, distance = 75.0; i < count;
    i++, distance += step) {
      children.add(
        ExpandingActionButton(
          distance: distance,
          progress: expandAnimation,
          child: buttons[i],
        ),
      );
    }
    return children;
  }

  Widget buildToOpen() {
    return IgnorePointer(
      ignoring: open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          open ? 0.7 : 1.0,
          open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: theme.colorScheme.onBackground,
            onPressed: toggle,
            child: Icon(Icons.settings, color: theme.colorScheme.background,),
          ),
        ),
      ),
    );
  }

  
}

class ExpandingActionButton extends StatelessWidget {
  final double distance;
  final Animation<double> progress;
  final Widget child;

  const ExpandingActionButton({
    required this.distance,
    required this.progress,
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return Positioned(
          right: 4.0,
          bottom: progress.value * distance,
          child: Transform.rotate(
              angle: (1.0 - progress.value) * pi / 2,
            child: child!)
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.onBackground,
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.background,
      ),
    );
  }
}



