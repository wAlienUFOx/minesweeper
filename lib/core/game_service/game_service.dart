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
  final Stopwatch stopwatch = Stopwatch();
  bool isWin = false;

  late LeaderboardService leaderboardService;
  late VibrationService vibrationService;

  void initService() {
    loadField();
    vibrationService = Get.find<VibrationService>();
    leaderboardService = Get.find<LeaderboardService>();
  }

  bool canContinue() => !gameField.newGame;

  void setTileCallbackFunction(Tile tile, void Function() callback) {
    gameField.field[tile.x][tile.y].callback = callback;
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
    gameField.savedTimer += stopwatch.elapsed.inSeconds;
    stopwatch.reset();
    stopwatch.stop();
    LocalStorage.savedField = gameField.toJson();
  }

  void cleanSavedField() {
    gameField.clear();
    LocalStorage.savedField = GameField(field: []).toJson();
  }

  void restartGame() {
    cleanSavedField();
    generateEmptyField(GameMode.fromGameField(gameField), true);
    flagsCounter.updateValue(0);
    callback();
  }

  void generateEmptyField(GameMode gameMode, bool restart) {
    isWin = false;
    gameField.newGame = true;
    gameField.generateEmptyField(gameMode, restart);
    flagsCounter.updateValue(0);
    stopwatch.reset();
    stopwatch.stop();
  }

  void checkIfWin() {
    if (!gameField.isWin()) return;
    if (isWin == true) return;
    isWin = true;

    stopwatch.stop();
    gameField.setToIgnore(false);

    int record = (stopwatch.elapsed.inSeconds) + gameField.savedTimer;
    leaderboardService.add(record, GameMode(width: gameField.width, height: gameField.height, mines: gameField.mines));
    Get.dialog(WinnerDialog(time: record)).then((newGame) {
      if (newGame != null && newGame) {
        restartGame();
      } else {
        cleanSavedField();
      }
    });
  }

  void gameOver() async {
    vibrationService.vibrate(duration: 1000);
    stopwatch.stop();
    gameField.setToIgnore(true);
    callback();
    await Future.delayed(const Duration(milliseconds: 100));
    cleanSavedField();
  }

  void changeFlag(Tile tile) {
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
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
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
    gameField.openByFlags(tile.x, tile.y, checkIfWin, gameOver);
  }

  void openTile(Tile tile) {
    if(!stopwatch.isRunning) {
      stopwatch.start();
    }
    if(gameField.newGame) {
      gameField.newGame = false;
      generateField(tile.x, tile.y, gameField.mines);
    }
    gameField.openTile(tile.x, tile.y, checkIfWin, gameOver);
  }

  void generateField(int firstX, int firstY, int mines) {
    gameField.generateField(firstX, firstY, mines);
    stopwatch.start();
  }
}