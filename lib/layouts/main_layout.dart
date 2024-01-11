import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/abstract_state.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final Widget? bottomButtons;
  final Widget? appBar;

  const MainLayout({
    super.key,
    required this.child,
    this.bottomButtons,
    this.appBar
  });

  static MainLayoutState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainLayoutState>();
  }

  @override
  State<StatefulWidget> createState() => MainLayoutState();
}

class MainLayoutState extends AbstractState<MainLayout> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mData = MediaQuery.of(context);

    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          double maxHeight = constraints.maxHeight - mData.viewInsets.collapsedSize.height;
          double maxWidth = constraints.maxWidth;

          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: theme.colorScheme.background,
                appBar: buildAppBar(),
                floatingActionButton: widget.bottomButtons,
                body: SizedBox(
                  width: mData.size.width,
                  height: mData.size.height,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: maxHeight,
                      minHeight: maxHeight,
                      minWidth: maxWidth,
                      maxWidth: maxWidth,
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        });
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 55),
      child: widget.appBar ?? const SizedBox.shrink()
    );
  }
}