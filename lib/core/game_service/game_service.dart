import 'dart:math';
import 'package:minesweeper/core/game_service/tile.dart';
import '../local_storage/local_storage.dart';

class GameService {
  List<List<Tile>> gameField = [];

  void init() => gameField = LocalStorage.hasSavedField() ? LocalStorage.savedField : [];
  void saveField() => LocalStorage.savedField = gameField;
  void cleanSavedField() => LocalStorage.clearSavedField();

  bool openTile(int x, int y) {
    for (int n = x - 1; n < x + 2; n++) {
      for (int m = y - 1; m < y + 2; m++) {
        if (n > 0 && m > 0 && n < gameField.length && m < gameField[0].length) {
          if (gameField[n][m].hasMine) {
            return false;
          } else {
            gameField[n][m].isOpen = true;
            if (gameField[n][m].digit == 0) openTile(n, m);
          }
        }
      }
    }
    saveField();
    return true;
  }

  void generateField(int width, int height, int mines, int firstX, int firstY) {
    if (LocalStorage.hasSavedField()) cleanSavedField();
    List<List<Tile>> result = List.filled(width, List.filled(height, Tile()));
    int x;
    int y;
    while (mines > 0) {
      x = Random().nextInt(width - 1);
      y = Random().nextInt(height - 1);
      if (!result[x][y].hasMine && !((firstX - x).abs() < 2 && (firstY - y).abs() < 2)) {
        result[x][y].hasMine = true;
        mines--;
        print('_____mines____');
      }
    }
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int digit = 0;
        for (int n = i - 1; n < i + 2; n++) {
          for (int m = j - 1; m < j + 2; m++) {
            if (n > 0 && m > 0 && n < width && m < width) {
              if (result[n][m].hasMine) digit++;
            }
          }
        }
        result[i][j].digit = digit;
      }
    }
    gameField = result;
  }
}