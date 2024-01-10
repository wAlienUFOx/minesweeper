import 'package:flutter/material.dart';
import 'package:minesweeper/layouts/main_layout.dart';

abstract class AbstractState<T extends StatefulWidget> extends State<T> {
  late ThemeData theme;
  late MainLayoutState? mainLayout;

  @override
  void initState() {
    super.initState();
    mainLayout = MainLayout.of(context);

    onInitPage();
  }

  void onInitPage() {}

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  void onDispose() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = Theme.of(context);

    onDidChangeDependencies();
  }

  void onDidChangeDependencies() {}
}