import 'package:minesweeper/core/local_storage/local_storage.dart';
import 'package:vibration/vibration.dart';

class VibrationService {
  late bool isOn;
  late bool hasVibration;

  Future<void> initService() async {
    hasVibration = await Vibration.hasVibrator() ?? false;
    String vibration = LocalStorage.vibrationMode ?? 'On';

    if  (vibration == 'On') {
      isOn = true;
    } else {
      isOn = false;
    }
  }

  void switchMode() {
    isOn = !isOn;
    if(isOn && hasVibration) vibrate();
    LocalStorage.vibrationMode = isOn ? "On" : "Off";
  }

  void vibrate({int duration = 100}) {
    Vibration.vibrate(duration: duration);
  }
}