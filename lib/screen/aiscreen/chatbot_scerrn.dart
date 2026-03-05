import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import '../../Constants.dart';

class SimpleChatScreen extends StatefulWidget {
  const SimpleChatScreen({super.key});

  @override
  State<SimpleChatScreen> createState() => _SimpleChatScreenState();
}

class _SimpleChatScreenState extends State<SimpleChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final _chatGpt = OpenAI.instance.build(
    token: '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', // ⚠️ ضع مفتاح API الخاص بك هنا
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chatbot',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xF59197CF),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message['isUser'];

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Color(0xF5848EDC) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Color(0xF59197CF),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();

    // إضافة رسالة المستخدم
    setState(() {
      _messages.add({'text': text, 'isUser': true});
    });

    try {
      // إعداد محادثة التاريخ
      final messagesHistory = _messages.reversed.map((msg) {
        if (msg['isUser']) {
          return {'role': 'user', 'content': msg['text']};
        } else {
          return {'role': 'assistant', 'content': msg['text']};
        }
      }).toList();

      // إرسال الطلب إلى ChatGPT
      final request = ChatCompleteText(
        // model: GptTurboChatModel(),
        // model: GptTurbo0613ChatModel(),
        // model: ChatModel.gpt3_5Turbo,
        /// - GptTurboChatModel();
        /// - GptTurbo0301ChatModel();
        model:  Gpt4ChatModel(),
        /// - Gpt40314ChatModel();
        /// - Gpt432kChatModel();
        /// - Gpt432k0314ChatModel();
        /// - ChatModelFromValue(model: 'your-model-name')
        messages: messagesHistory,
        maxToken: 200,
      );

      final response = await _chatGpt.onChatCompletion(request: request);

      // ✅ التحقق من الاستجابة بشكل صحيح
      if (response == null) {
        setState(() {
          _messages.add({
            'text': 'لم يتم تلقي رد من المساعد',
            'isUser': false
          });
        });
        return;
      }

      if (response.choices != null && response.choices.isNotEmpty) {
        for (final element in response.choices) {
          if (element.message != null) {
            setState(() {
              _messages.add({
                'text': element.message!.content,
                'isUser': false
              });
            });
          }
        }
      } else {
        setState(() {
          _messages.add({
            'text': 'لا توجد ردود متاحة',
            'isUser': false
          });
        });
      }
    } catch (e) {
      print('خطأ: $e');

      // رسائل خطأ أكثر وضوحاً
      String errorMessage = 'عذراً، حدث خطأ';

      if (e.toString().contains('model_not_found')) {
        errorMessage = 'تم تحديث خدمة المحادثة';
      } else if (e.toString().contains('404')) {
        errorMessage = 'تعذر الاتصال بالخدمة';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'انتهت مهلة الاتصال بالخادم';
      }

      setState(() {
        _messages.add({
          'text': errorMessage,
          'isUser': false
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
