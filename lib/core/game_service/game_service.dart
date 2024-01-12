import 'dart:math';
import 'package:get/get.dart';
import 'package:minesweeper/core/game_service/game_mode.dart';
import 'package:minesweeper/core/game_service/tile.dart';
import 'package:minesweeper/widgets/dialogs/winner_dialog.dart';
import '../local_storage/local_storage.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GameService {
  late List<List<Tile>> gameField;
  late int savedTimer;
  int width = 0;
  int height = 0;
  int mines = 0;
  bool newGame = true;

  FormControl<int> flagsCounter = FormControl(value: 0);
  FormControl<bool> needChangeState = FormControl(value: false);
  final Stopwatch stopwatch = Stopwatch();

  void initService() {
    loadField();
  }

  bool canContinue() => gameField.isNotEmpty;

  void loadField() {
    print(LocalStorage.savedField);
    print(LocalStorage.savedTimer);
    gameField = LocalStorage.savedField ?? [];
    if (gameField.isNotEmpty) {
      width = gameField.length;
      height = gameField[0].length;
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          if (gameField[x][y].hasMine) mines++;
          if (gameField[x][y].hasFlag) flagsCounter.updateValue(flagsCounter.value! + 1);
        }
      }
    }
    savedTimer = LocalStorage.savedTimer ?? 0;
  }

  void saveField() {
    print('____________saving_______');
    LocalStorage.savedField = gameField;
    LocalStorage.savedTimer = (stopwatch.elapsedMilliseconds ~/ 1000) + savedTimer;
  }
  void cleanSavedField() {
    gameField.clear();
    LocalStorage.savedField = [];
  }

  void restartGame() {
    cleanSavedField();
    generateEmptyField(GameMode(width: width, height: height, mines: mines));
    flagsCounter.updateValue(0);
    needChangeState.updateValue(!needChangeState.value!);
  }

  void generateEmptyField(GameMode gameMode) {
    newGame = true;
    gameField = [];
    flagsCounter.updateValue(0);
    savedTimer = 0;
    mines = gameMode.mines;
    width = gameMode.width;
    height = gameMode.height;
    stopwatch.reset();
    stopwatch.stop();
    for (int x = 0; x < width; x++) {
      gameField.add([]);
      for (int y = 0; y < height; y++) {
        gameField[x].add(Tile(x: x, y: y));
      }
    }
  }

  void checkIfWin() {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (!gameField[x][y].hasMine && !gameField[x][y].isOpen) {
          return;
        }
      }
    }
    //winner
    stopwatch.stop();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        gameField[x][y].ignore = true;
      }
    }
    Get.dialog(WinnerDialog(time: (stopwatch.elapsedMilliseconds ~/ 1000) + savedTimer)).then((newGame) {
      if (newGame != null && newGame) {
        restartGame();
      } else {
        cleanSavedField();
      }
    });
  }

  void gameOver() async {
    stopwatch.stop();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (gameField[x][y].hasMine) gameField[x][y].isOpen = true;
        gameField[x][y].ignore = true;
      }
    }
    needChangeState.updateValue(!needChangeState.value!);
    Future.delayed(const Duration(seconds: 1)).then((value) => cleanSavedField());
  }

  void changeFlag(int x, int y) {
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
    if (gameField[x][y].hasFlag == false) {
      flagsCounter.updateValue(flagsCounter.value! + 1);
    } else {
      flagsCounter.updateValue(flagsCounter.value! - 1);
    }
    gameField[x][y].hasFlag = !gameField[x][y].hasFlag;
    needChangeState.updateValue(!needChangeState.value!);
  }

  void openByFlags(int x, int y) {
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
    int flagsAround = 0;
    for (int i = x-1; i <= x+1; i++) {
      if (i >= 0 && i < width) {
        for (int j = y-1; j <= y+1; j++) {
          if (j >= 0 && j < height) {
            if((i != x || j != y) && gameField[i][j].hasFlag) flagsAround++;
          }
        }
      }
    }
    if (flagsAround != gameField[x][y].digit) return;

    for (int i = x-1; i <= x+1; i++) {
      if (i >= 0 && i < width) {
        for (int j = y-1; j <= y+1; j++) {
          if (j >= 0 && j < height) {
            if((i != x || j != y) && !gameField[i][j].hasFlag && !gameField[i][j].isOpen) openTile(i, j);
          }
        }
      }
    }
  }

  void openTile(int x, int y) {
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
    if(newGame) {
      newGame = false;
      generateField(x, y, mines);
    }
    if(gameField[x][y].isOpen) return;
    if(gameField[x][y].hasMine) {
      gameOver();
    } else {
      gameField[x][y].isOpen = true;
      if(gameField[x][y].digit == 0) {
        for (int i = x-1; i <= x+1; i++) {
          if (i >= 0 && i < width) {
            for (int j = y-1; j <= y+1; j++) {
              if (j >= 0 && j < height) {
                if(i != x || j != y) openTile(i, j);
              }
            }
          }
        }
      } else {
        for (int i = x-1; i <= x+1; i++) {
          if (i >= 0 && i < width) {
            for (int j = y-1; j <= y+1; j++) {
              if (j >= 0 && j < height) {
                if((i != x || j != y) && gameField[i][j].digit == 0 && !gameField[i][j].hasMine) openTile(i, j);
              }
            }
          }
        }
      }
    }
    needChangeState.updateValue(!needChangeState.value!);
    checkIfWin();
  }

  void generateField(int firstX, int firstY, int mines) async {
    int x;
    int y;
    while (mines > 0) {
      x = Random().nextInt(width);
      y = Random().nextInt(height);
      if (!gameField[x][y].hasMine && !((firstX - x).abs() < 2 && (firstY - y).abs() < 2)) { //
        gameField[x][y] = Tile(x: x, y: y, hasMine: true);
        mines--;
      }
    }
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        if (gameField[i][j].hasMine) {
          for (int n = i-1; n <= i+1; n++) {
            if (n >= 0 && n < width) {
              for (int m = j-1; m <= j+1; m++) {
                if (m >= 0 && m < height) {
                  if (n != i || m != j) gameField[n][m].digit++;
                }
              }
            }
          }
        }
      }
    }
    stopwatch.start();
  }
}