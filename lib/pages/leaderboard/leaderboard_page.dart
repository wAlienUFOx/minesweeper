import 'package:flutter/material.dart';
import 'package:minesweeper/core/game_service/game_mode/game_mode.dart';
import 'package:minesweeper/core/leaderboard_service/leaderboard_item/leaderboard_item.dart';
import 'package:minesweeper/core/leaderboard_service/leaderboard_service.dart';
import 'package:minesweeper/widgets/abstract_state.dart';
import 'package:get/get.dart';
import 'package:minesweeper/widgets/dialogs/confirm_dialog.dart';
import 'package:minesweeper/widgets/slide_button.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({
    super.key
  });

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends AbstractState<LeaderboardPage> {

  late LeaderboardService leaderboardService;
  int pageIndex = 0;
  PageController pageController = PageController();

  onSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) {
      return;
    }
    if (details.primaryVelocity! > 0 && pageIndex > 0)  animateToPage(pageIndex - 1);
    if (details.primaryVelocity! < 0 && pageIndex < 2) animateToPage(pageIndex + 1);
  }

  void animateToPage(int index) {
    pageIndex = index;
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {});
  }

  @override
  void onInitPage() {
    leaderboardService = Get.find<LeaderboardService>();
    super.onInitPage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: onSwipe,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  late String title;
                  late GameMode gameMode;
                  late List<LeaderboardItem> leaderBoard;
                  if (index == 0) {
                    title = 'Beginner';
                    leaderBoard = leaderboardService.leaderboard.beginner;
                    gameMode = GameMode.beginner();
                  }
                  if (index == 1) {
                    title = 'Medium';
                    leaderBoard = leaderboardService.leaderboard.medium;
                    gameMode = GameMode.medium();
                  }
                  if (index == 2) {
                    title = 'Expert';
                    leaderBoard = leaderboardService.leaderboard.expert;
                    gameMode = GameMode.expert();
                  }
                  return Column(
                    children: [
                      Text(title, style: TextStyle(color: theme.colorScheme.onBackground, fontSize: 30)),
                      const SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...leaderBoard.map((item) => buildBoardItem(item, gameMode))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15)
                    ],
                  );
                },
              ),
            ),
            SlideButton(pageIndex: pageIndex, callback: animateToPage, fontColor: theme.colorScheme.primary)
          ],
        ),
      ),
    );
  }

  Widget buildBoardItem(LeaderboardItem item, GameMode gameMode) {
    TextStyle textStyle = TextStyle(color: theme.colorScheme.onBackground, fontSize: 20);
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dateToString(item.dateTime), style: textStyle),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(timeToBoard(item.time), style: textStyle),
              const SizedBox(width: 5),
              IconButton(
                  onPressed: () => Get.dialog(const ConfirmDialog(event: 'remove item')).then((result) {
                    if (result != null && result) {
                      leaderboardService.remove(item, gameMode);
                      setState(() {});
                    }
                  }),
                  icon: Icon(Icons.delete, color: theme.colorScheme.onBackground, size: 25)
              )
            ],
          )
        ],
      ),
    );
  }

  String dateToString(DateTime dateTime) {
    return '${digitToString(dateTime.day)}-${digitToString(dateTime.month)}-${digitToString(dateTime.year)} '
        '${digitToString(dateTime.hour)}:${digitToString(dateTime.minute)}:${digitToString(dateTime.second)}';
  }
  String digitToString(int digit) {
    if(digit.toString().length > 1) return digit.toString();
    return '0$digit';
  }

  String timeToBoard(int time) {
    if (time < 60) return '${time}s';
    int minutes;
    int seconds;
    minutes = time ~/ 60;
    seconds = time - (minutes * 60);
    return '${minutes}m ${seconds}s';
  }
}