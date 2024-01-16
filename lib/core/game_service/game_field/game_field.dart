import 'dart:math';
import 'package:minesweeper/core/tile/tile.dart';
import 'package:json_annotation/json_annotation.dart';
import '../game_mode/game_mode.dart';
part 'game_field.g.dart';

@JsonSerializable()
class GameField {
  List<List<Tile>> field;
  int width;
  int height;
  int mines;
  int savedTimer;
  int openTiles;
  bool newGame;

  GameField({
    required this.field,
    this.width = 0,
    this.height = 0,
    this.mines = 0,
    this.savedTimer = 0,
    this.openTiles = 0,
    this.newGame = true
  });

  void clear() {
    savedTimer = 0;
    openTiles = 0;
    newGame = true;
  }

  void generateEmptyField(GameMode gameMode, bool restart) {
    savedTimer = 0;
    openTiles = 0;
    if (restart) {
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          field[x][y] = Tile(x: x, y: y, callback: field[x][y].callback);
        }
      }
    } else {
      field = [];
      mines = gameMode.mines;
      width = gameMode.width;
      height = gameMode.height;
      for (int x = 0; x < width; x++) {
        field.add([]);
        for (int y = 0; y < height; y++) {
          field[x].add(Tile(x: x, y: y, callback: () => {}));
        }
      }
    }
  }

  bool isWin() {
    return openTiles == (width * height) - mines;
  }

  void setToIgnore(bool isLoose) {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (field[x][y].hasMine && isLoose) field[x][y].isOpen = true;
        field[x][y].ignore = true;
      }
    }
  }

  void openByFlags(int x, int y, void Function() checkIfWin, void Function() gameOver) {
    int flagsAround = 0;
    for (int i = x-1; i <= x+1; i++) {
      if (i >= 0 && i < width) {
        for (int j = y-1; j <= y+1; j++) {
          if (j >= 0 && j < height) {
            if((i != x || j != y) && field[i][j].hasFlag) flagsAround++;
          }
        }
      }
    }
    if (flagsAround != field[x][y].digit) return;

    for (int i = x-1; i <= x+1; i++) {
      if (i >= 0 && i < width) {
        for (int j = y-1; j <= y+1; j++) {
          if (j >= 0 && j < height) {
            if((i != x || j != y) && !field[i][j].hasFlag && !field[i][j].isOpen) openTile(i, j, checkIfWin, gameOver);
          }
        }
      }
    }
  }

  void openTile(int x, int y, void Function() checkIfWin, void Function() gameOver) {
    if(field[x][y].isOpen) return;
    if(field[x][y].hasMine) {
      gameOver();
      return;
    }
    field[x][y].isOpen = true;
    openTiles++;
    if(field[x][y].digit == 0) {
      for (int i = x-1; i <= x+1; i++) {
        if (i >= 0 && i < width) {
          for (int j = y-1; j <= y+1; j++) {
            if (j >= 0 && j < height) {
              if(i != x || j != y) openTile(i, j, checkIfWin, gameOver);
            }
          }
        }
      }
    } else {
      for (int i = x-1; i <= x+1; i++) {
        if (i >= 0 && i < width) {
          for (int j = y-1; j <= y+1; j++) {
            if (j >= 0 && j < height) {
              if((i != x || j != y) && field[i][j].digit == 0 && !field[i][j].hasMine) openTile(i, j, checkIfWin, gameOver);
            }
          }
        }
      }
    }
    field[x][y].callback();
    checkIfWin();
  }

  void generateField(int firstX, int firstY, int mines) {
    int x;
    int y;
    while (mines > 0) {
      x = Random().nextInt(width);
      y = Random().nextInt(height);
      if (!field[x][y].hasMine && !((firstX - x).abs() < 2 && (firstY - y).abs() < 2)) { //
        field[x][y].hasMine = true;
        mines--;
      }
    }
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        if (field[i][j].hasMine) {
          for (int n = i-1; n <= i+1; n++) {
            if (n >= 0 && n < width) {
              for (int m = j-1; m <= j+1; m++) {
                if (m >= 0 && m < height) {
                  if (n != i || m != j) field[n][m].digit++;
                }
              }
            }
          }
        }
      }
    }
  }

  factory GameField.fromJson(Map<String, dynamic> json) => _$GameFieldFromJson(json);
  Map<String, dynamic> toJson() => _$GameFieldToJson(this);
}