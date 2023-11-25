import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CardController extends GetxController {
  static CardController get to => Get.find();

  downloadBook(String urlParam, String titleBook) async {
    Uri url = Uri.parse(urlParam);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      Exception(e);
    }
  }
}
