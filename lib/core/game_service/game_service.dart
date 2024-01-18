import 'dart:async';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/game_field/game_field.dart';
import 'package:minesweeper/core/game_service/game_mode/game_mode.dart';
import 'package:minesweeper/core/leaderboard_service/leaderboard_service.dart';
import 'package:minesweeper/core/vibration_service/vibration_service.dart';
import 'package:minesweeper/widgets/dialogs/winner_dialog.dart';
import '../local_storage/local_storage.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../tile/tile.dart';

class GameService {
  GameField gameField = GameField(field: []);

  FormControl<int> flagsCounter = FormControl(value: 0);
  late void Function() callback;
  late void Function() updateTimer;
  late Timer timer;
  bool isWin = false;
  bool timerInit = true;
  int timerTick = 0;

  late LeaderboardService leaderboardService;
  late VibrationService vibrationService;

  void initService() {
    loadField();
    vibrationService = Get.find<VibrationService>();
    leaderboardService = Get.find<LeaderboardService>();
  }

  bool canContinue() => !gameField.newGame;

  void pauseTimer() {
    if (timerTick != 0) timerTick = 0;
  }

  void startTimer(){
    if (timerInit) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        gameField.savedTimer += timerTick;
        updateTimer();
      });
      timerInit = false;
    }
    if (timerTick == 0) timerTick = 1;
  }

  void loadField() {
    if (LocalStorage.savedField != null) {
      gameField = GameField.fromJson(LocalStorage.savedField!);
    } else {
      gameField = GameField(field: []);
    }
    if (gameField.field.isNotEmpty) {
      for (int x = 0; x < gameField.width; x++) {
        for (int y = 0; y < gameField.height; y++) {
          if (gameField.field[x][y].hasFlag) flagsCounter.updateValue(flagsCounter.value! + 1);
        }
      }
    }
  }

  void saveField() {
    pauseTimer();
    LocalStorage.savedField = gameField.toJson();
  }

  void cleanSavedField() {
    gameField.clear();
    LocalStorage.savedField = GameField(field: []).toJson();
  }

  void restartGame() {
    cleanSavedField();
    pauseTimer();
    generateEmptyField(GameMode.fromGameField(gameField), true);
    flagsCounter.updateValue(0);
    updateTimer();
    callback();
  }

  void generateEmptyField(GameMode gameMode, bool restart) {
    isWin = false;
    gameField.newGame = true;
    gameField.generateEmptyField(gameMode, restart);
    flagsCounter.updateValue(0);
  }

  void checkIfWin() {
    if (!gameField.isWin()) return;
    if (isWin == true) return;
    isWin = true;

    pauseTimer();
    gameField.setToIgnore(false);
    callback();

    leaderboardService.add(gameField.savedTimer, GameMode(width: gameField.width, height: gameField.height, mines: gameField.mines));
    Get.dialog(WinnerDialog(time: gameField.savedTimer)).then((newGame) {
      if (newGame != null && newGame) {
        restartGame();
      } else if (newGame != null && !newGame) {
        cleanSavedField();
        Get.offAllNamed('/home');
      } else {
        cleanSavedField();
      }
    });
  }

  void gameOver() async {
    vibrationService.vibrate(duration: 1000);
    pauseTimer();
    gameField.setToIgnore(true);
    callback();
    await Future.delayed(const Duration(milliseconds: 100));
    cleanSavedField();
  }

  void changeFlag(Tile tile) {
    startTimer();
    if (gameField.field[tile.x][tile.y].hasFlag == false) {
      flagsCounter.updateValue(flagsCounter.value! + 1);
      vibrationService.vibrate();
    } else {
      flagsCounter.updateValue(flagsCounter.value! - 1);
    }
    gameField.field[tile.x][tile.y].hasFlag = !gameField.field[tile.x][tile.y].hasFlag;
    gameField.field[tile.x][tile.y].callback();
  }

  void openByFlags(Tile tile) {
    startTimer();
    gameField.openByFlags(tile.x, tile.y, checkIfWin, gameOver);
  }

  void openTile(Tile tile) {
    startTimer();
    if(gameField.newGame) {
      gameField.newGame = false;
      generateField(tile.x, tile.y, gameField.mines);
    }
    gameField.openTile(tile.x, tile.y, checkIfWin, gameOver);
  }

  void generateField(int firstX, int firstY, int mines) {
    gameField.generateField(firstX, firstY, mines);
    startTimer();
  }
}