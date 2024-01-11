import 'dart:math';
import 'package:minesweeper/core/game_service/tile.dart';
import '../local_storage/local_storage.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GameService {
  List<List<Tile>> gameField = [];
  FormControl<int> flagsCounter = FormControl(value: 0);
  FormControl<int> timerValue = FormControl(value: 0);
  FormControl<bool> needChangeState = FormControl(value: false);
  bool newGame = true;
  int width = 0;
  int height = 0;
  int mines = 0;

  void initService() {
    gameField = LocalStorage.hasSavedField() ? LocalStorage.savedField : [];
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
  }

  void saveField() => LocalStorage.savedField = gameField;
  void cleanSavedField() {
    if(LocalStorage.hasSavedField()) LocalStorage.clearSavedField();
  }

  void restartGame() {
    generateEmptyField(width, height, mines);
    flagsCounter.updateValue(0);
    cleanSavedField();
    needChangeState.updateValue(true);
    needChangeState.updateValue(false);
  }

  void generateEmptyField(int fieldWidth, int fieldHeight, int fieldMines) {
    newGame = true;
    gameField = [];
    flagsCounter.updateValue(0);
    mines = fieldMines;
    width = fieldWidth;
    height = fieldHeight;
    for (int x = 0; x < width; x++) {
      gameField.add([]);
      for (int y = 0; y < height; y++) {
        gameField[x].add(Tile(x: x, y: y));
      }
    }
  }

  bool checkIfWin() {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (!gameField[x][y].hasMine && !gameField[x][y].isOpen) {
          return false;
        }
      }
    }
    return true;
  }

  void gameOver() {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (gameField[x][y].hasMine) gameField[x][y].isOpen = true;
        gameField[x][y].ignore = true;
      }
    }
    needChangeState.updateValue(true);
    needChangeState.updateValue(false);
  }

  void changeFlag(int x, int y) {
    if (gameField[x][y].hasFlag == false) {
      flagsCounter.updateValue(flagsCounter.value! + 1);
    } else {
      flagsCounter.updateValue(flagsCounter.value! - 1);
    }
    gameField[x][y].hasFlag = !gameField[x][y].hasFlag;
    needChangeState.updateValue(true);
    needChangeState.updateValue(false);
  }

  void openByFlags(int x, int y) {
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
    needChangeState.updateValue(true);
    needChangeState.updateValue(false);
    saveField();
    //check if win;
  }

  void generateField(int firstX, int firstY, int mines) async {
    if (LocalStorage.hasSavedField()) cleanSavedField();
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
  }
}