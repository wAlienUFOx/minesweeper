import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:minesweeper/core/theme_service/theme_service.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<GetStorage>(() => GetStorage(), fenix: true);

    Get.put(ThemeService());
  }
}