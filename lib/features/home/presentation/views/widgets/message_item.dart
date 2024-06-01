import 'package:flutter/material.dart';
import 'package:gemini_chat/features/home/data/models/message_models.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.message,
    required this.isDark,
  });

  final MessageModel message;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.isSender == false
              ? isDark
                  ? Colors.white
                  : Colors.grey[300]
              : Colors.green,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            topLeft: Radius.circular(message.isSender ? 20 : 0),
            bottomRight: Radius.circular(
              message.isSender ? 0 : 20,
            ),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color:
                message.isSender ? Colors.white : Colors.black.withOpacity(0.7),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
