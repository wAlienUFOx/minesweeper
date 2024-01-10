import 'package:flutter/material.dart';
import 'package:minesweeper/widgets/abstract_state.dart';
import 'package:minesweeper/widgets/app_button.dart';
import '../../widgets/group_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AbstractState<HomePage> {

  List<GroupButton> menuItems = [
    GroupButton(
        title: 'Continue',
        onTap: () => {}
    ),
    GroupButton(
        title: 'New game',
        onTap: () => {}
    ),
    GroupButton(
        title: 'Records',
        onTap: () => {}
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: menuItems.map<Widget>((item) => buildMenuItem(item)).toList()
    );
  }

  Widget buildMenuItem(GroupButton item) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: AppButton(
          onPressed: item.onTap,
          title: item.title,
          color: theme.colorScheme.primary
      ),
    );
  }
}