import 'package:chat_app/app/module/search_screen/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<SearchControllerGroup>(SearchControllerGroup());
  }
}
