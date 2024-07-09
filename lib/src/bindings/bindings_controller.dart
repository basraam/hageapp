import 'package:get/get.dart';
import 'package:hage_mobile_app/src/utils/network_manager/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());

  }

}