import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper/core/settings_service/settings_service.dart';
import 'package:minesweeper/core/vibration_service/vibration_service.dart';
import 'dart:math';
import 'package:minesweeper/widgets/abstract_state.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends AbstractState<SettingsWidget> with SingleTickerProviderStateMixin {

  late List<ActionButton> buttons;
  late SettingsService settingsService;
  late VibrationService vibrationService;
  late final AnimationController controller;
  late final Animation<double> expandAnimation;
  bool open = false;

  @override
  void onInitPage() {
    settingsService = Get.find<SettingsService>();
    vibrationService = Get.find<VibrationService>();
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    buttons = [
      ActionButton(
          onPressed: () => settingsService.changeTheme(),
          icon: const Icon(Icons.sunny)
      ),
      ActionButton(
          onPressed: () {
            vibrationService.switchMode();
            setState(() {});
          },
          icon: Icon(vibrationService.isOn ? Icons.vibration : Icons.phone_android)
      ),
      ActionButton(
          onPressed: () {
            settingsService.switchFlagMode();
            setState(() {});
          },
          icon: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.flag, color: Color.fromARGB(255, 165, 42, 42), size: 30,),
              Positioned(
                  top: 8,
                  child: Icon(settingsService.flagMode == FlagMode.doubleTap
                      ? Icons.keyboard_double_arrow_down
                      : Icons.vertical_align_bottom,
                  )
              ),
            ],
          )
      ),
      ActionButton(
          onPressed: () {
            settingsService.switchBoundaryMode();
            setState(() {});
          },
          icon: Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(angle: pi / 2, child: const Icon(Icons.rectangle_outlined, size: 30,)),
              Positioned(
                  left: settingsService.wideBoundary ? 12 : null,
                  child: Transform.rotate(angle: pi / 2, child: const Icon(Icons.rectangle_outlined, size: 20))
              ),
            ],
          )
      )
    ];

    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          ...buildButtons(),
          buildToOpen()
        ],
      ),
    );
  }

  List<Widget> buildButtons() {
    final children = <Widget>[];
    final count = buttons.length;
    const step = 50;
    for (var i = 0, distance = 60.0; i < count;
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
    return FloatingActionButton(
      backgroundColor: theme.colorScheme.onBackground,
      onPressed: toggle,
      child: Icon(
          open ? Icons.close : Icons.settings,
          color: theme.colorScheme.primary
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
              child: child!
          )
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
        color: theme.colorScheme.primary,
      ),
    );
  }
}



