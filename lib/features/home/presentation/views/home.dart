// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_chat/features/home/data/models/message_models.dart';
import 'package:gemini_chat/features/home/presentation/views/widgets/app_bar.dart';
import 'package:gemini_chat/features/home/presentation/views/widgets/decoration.dart';
import 'package:gemini_chat/features/home/presentation/views/widgets/form_field.dart';
import 'package:gemini_chat/features/home/presentation/views/widgets/message_item.dart';
import 'package:gemini_chat/features/home/presentation/views/widgets/send_Icon.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController controller = TextEditingController();
  bool isDark = false;
  bool isLoading = false;

  final List<MessageModel> mesages = [];

  callGeminiModel() async {
    try {
      if (controller.text.isNotEmpty) {
        mesages.add(MessageModel(
          message: controller.text,
          isSender: true,
        ));
        isLoading = true;
        setState(() {});
      }
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: dotenv.env['GOOGLE_API_KEY']!,
      );

      final prompt = controller.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        mesages.add(MessageModel(message: response.text!, isSender: false));
        isLoading = false;
      });
      controller.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: appBar(
        isDark: isDark,
        widget: InkWell(
          onTap: () {
            setState(() {
              isDark = !isDark;
            });
          },
          child: isDark
              ? const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.sunny,
                    color: Colors.white,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.dark_mode,
                  ),
                ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mesages.length,
                itemBuilder: (context, index) {
                  final message = mesages[index];
                  return ListTile(
                    title: MessageItem(
                      message: message,
                      isDark: isDark,
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: 20,
                top: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: decoration(isDark: isDark),
              child: Row(
                children: [
                  FormFieldMessage(
                    controller: controller,
                    isDark: isDark,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: isLoading
                        ? const SizedBox(
                            height: 10,
                            child: SpinKitThreeBounce(color: Colors.green),
                          )
                        : GestureDetector(
                            onTap: callGeminiModel,
                            child: const SendIcon(),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
