import 'package:get/get.dart';
import 'package:minesweeper/core/game_field/game_field.dart';
import 'package:minesweeper/core/game_mode/game_mode.dart';
import 'package:minesweeper/widgets/dialogs/winner_dialog.dart';
import '../local_storage/local_storage.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GameService {
  GameField gameField = GameField(field: []);

  FormControl<int> flagsCounter = FormControl(value: 0);
  FormControl<bool> needChangeState = FormControl(value: false);
  final Stopwatch stopwatch = Stopwatch();

  void initService() {
    loadField();
  }

  bool canContinue() => gameField.field.isNotEmpty;

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
    gameField.savedTimer = stopwatch.elapsed.inSeconds;
    LocalStorage.savedField = gameField.toJson();
  }
  void cleanSavedField() {
    gameField.clear();
    LocalStorage.savedField = GameField(field: []).toJson();
  }

  void restartGame() {
    cleanSavedField();
    generateEmptyField(GameMode.fromGameField(gameField));
    flagsCounter.updateValue(0);
    needChangeState.updateValue(!needChangeState.value!);
  }

  void generateEmptyField(GameMode gameMode) {
    gameField.newGame = true;
    gameField.generateEmptyField(gameMode);
    flagsCounter.updateValue(0);
    stopwatch.reset();
    stopwatch.stop();
  }

  void checkIfWin() {
    if (!gameField.isWin()) return;

    stopwatch.stop();
    gameField.setToIgnore(false);
    Get.dialog(WinnerDialog(time: (stopwatch.elapsed.inSeconds) + gameField.savedTimer)).then((newGame) {
      if (newGame != null && newGame) {
        restartGame();
      } else {
        cleanSavedField();
      }
    });
  }

  void gameOver() async {
    stopwatch.stop();
    gameField.setToIgnore(true);
    needChangeState.updateValue(!needChangeState.value!);
    cleanSavedField();
  }

  void changeFlag(int x, int y) {
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
    if (gameField.field[x][y].hasFlag == false) {
      flagsCounter.updateValue(flagsCounter.value! + 1);
    } else {
      flagsCounter.updateValue(flagsCounter.value! - 1);
    }
    gameField.field[x][y].hasFlag = !gameField.field[x][y].hasFlag;
    needChangeState.updateValue(!needChangeState.value!);
  }

  void openByFlags(int x, int y) {
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
    gameField.openByFlags(x, y, needChangeState, checkIfWin);
  }

  void openTile(int x, int y) {
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
    if(gameField.newGame) {
      gameField.newGame = false;
      generateField(x, y, gameField.mines);
    }
    if(gameField.field[x][y].hasMine) {
      gameOver();
    } else {
      gameField.openTile(x, y, needChangeState, checkIfWin);
    }
  }

  void generateField(int firstX, int firstY, int mines) {
    gameField.generateField(firstX, firstY, mines);
    stopwatch.start();
  }
}