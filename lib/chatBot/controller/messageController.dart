import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../services/api_Service.dart';

class MessageController extends GetxController {
  var responseText = "".obs;
  var messages = <Map<String, dynamic>>[].obs;
  var isTyping = false.obs;

  Future<void> sendMessage(String message) async {
    messages.add(
      {
        'text': message,
        'isUser': true,
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      },
    );

    responseText.value = "Thinking...";
    isTyping.value = true;
    update();

    String reply = await ApiService.getApiResponse(message);

    // Add AI Response
    messages.add(
      {
        'text': reply,
        'isUser': false,
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      },
    );

    responseText.value = reply;
    isTyping.value = false;
    update();
  }
}
