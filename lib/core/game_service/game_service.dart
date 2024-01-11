import 'dart:math';
import 'package:minesweeper/core/game_service/tile.dart';
import '../local_storage/local_storage.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GameService {
  List<List<Tile>> gameField = [];
  FormControl<int> flagsCounter = FormControl(value: 0);
  FormControl<int> timerValue = FormControl(value: 0);
  FormControl<bool> needChangeState = FormControl(value: false);
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

  bool openTile(int x, int y) {
    for (int n = x - 1; n < x + 2; n++) {
      for (int m = y - 1; m < y + 2; m++) {
        if (n > 0 && m > 0 && n < gameField.length && m < gameField[0].length) {
          if (gameField[n][m].hasMine) {
            return false;
          } else {
            gameField[n][m].isOpen = true;
            if (gameField[n][m].digit == 0 && !gameField[n][m].isOpen) openTile(n, m);
          }
        }
      }
    }
    saveField();
    return true;
  }

  void generateField(int firstX, int firstY) async {
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
    openTile(firstX, firstY);
  }
}