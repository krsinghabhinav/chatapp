import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/messageController.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController messageController = Get.put(MessageController());
  final TextEditingController chatMessageControl = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messageController.messages.listen((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "ChatBot",
          style: TextStyle(color: Colors.black),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemCount: messageController.messages.length,
                itemBuilder: (context, index) {
                  final message = messageController.messages[index];
                  final isUser = message['isUser'] as bool;
                  final time = message['time'] as String;

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        BubbleSpecialTwo(
                          isSender: isUser,
                          color: isUser
                              ? const Color(
                                  0XFF25D366) // Green for user messages
                              : const Color(
                                  0XFFE5E5E5), // Light gray for bot messages
                          seen: true,
                          text: message['text'],
                          tail: true,
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: isUser
                                ? Colors
                                    .white // Ensures readability on green background
                                : Colors
                                    .black, // Ensures readability on light gray background
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 20),
                          child: Text(
                            time,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          Obx(
            () => messageController.isTyping.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          messageController.responseText.value,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chatMessageControl,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 2),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions_outlined),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: "send_button",
                  onPressed: () {
                    if (chatMessageControl.text.isNotEmpty) {
                      messageController
                          .sendMessage(chatMessageControl.text.trim());
                      chatMessageControl.clear();
                      
                    }
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
