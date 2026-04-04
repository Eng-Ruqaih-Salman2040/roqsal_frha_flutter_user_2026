

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../shop_details/details.dart';
import '../shop_details/shop_details.dart';
import 'modl_ai.dart';

class Screen_Ai extends StatefulWidget {
  const Screen_Ai({super.key});

  @override

  State<Screen_Ai> createState() => _Screen_AiState();
}

class _Screen_AiState extends State<Screen_Ai> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];
  bool _isLoading = false;


  @override

  void initState() {
    super.initState();
    // رسالة ترحيب من الذكاء الاصطناعي

  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    // إضافة رسالة المستخدم
    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text,
          isUser: true,
        ),
      );
      _isLoading = true;
    });

    String userMessage = _messageController.text;
    _messageController.clear();

    // التمرير لأسفل
    _scrollToBottom();

    // استدعاء API
    try {
      //  استخدام userMessage: بدلاً من تمريرها مباشرة
      ServiceModel? result = await Ai.getai(userMessage: userMessage);

      setState(() {
        _isLoading = false;

        if (result != null) {
          _messages.add(
            ChatMessage(
              text: result.message,
              isUser: false,
              services: result.services,
              totalCost: result.totalCost,
              remainingBudget: result.remainingBudget,
            ),
          );
        } else {
          _messages.add(
            ChatMessage(
              text: 'عذراً، حدث خطأ في معالجة طلبك. الرجاء المحاولة مرة أخرى.',
              isUser: false,
            ),
          );
        }
      });

      _scrollToBottom();

    } catch (e) {
      setState(() {
        _isLoading = false;
        _messages.add(
          ChatMessage(
            text: 'حدث خطأ في الاتصال. تأكد من اتصالك بالإنترنت.',
            isUser: false,
          ),
        );
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.auto_awesome, size: 20),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المساعد الذكي',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            // منطقة الرسائل
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(message: message);
                },
              ),
            ),

            // مؤشر الكتابة
            if (_isLoading)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.deepPurple.shade100,
                      child: const Icon(Icons.auto_awesome, size: 12, color: Colors.deepPurple),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Text('المساعد الذكي يكتب'),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 20,
                            child: LinearProgressIndicator(
                              color: Colors.deepPurple,
                              backgroundColor: Colors.deepPurple.shade100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // منطقة إدخال النص
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -2),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالتك هنا...',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.attach_file, color: Colors.deepPurple),
                            onPressed: () {
                              // إضافة مرفقات (اختياري)
                            },
                          ),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
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
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

// كلاس الرسالة
class ChatMessage {
  final String text;
  final bool isUser;
  final List<Service>? services;
  final int? totalCost;
  final int? remainingBudget;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.services,
    this.totalCost,
    this.remainingBudget,
  });
}

// فقاعة الشات
class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.orange,
              child: const Icon(Icons.auto_awesome, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isUser ? Colors.deepPurple : Colors.white,
                    borderRadius: BorderRadius.circular(20).copyWith(
                      bottomLeft: message.isUser ? const Radius.circular(20) : const Radius.circular(4),
                      bottomRight: message.isUser ? const Radius.circular(4) : const Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // نص الرسالة
                      Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),

                      // عرض الخدمات إذا وجدت
                      if (message.services != null && message.services!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Container(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: message.services!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 180,
                                margin: const EdgeInsets.only(left: 8),
                                child: ServiceCard(service: message.services![index]),
                              );
                            },
                          ),
                        ),

                        // عرض ملخص التكاليف
                        if (message.totalCost != null && message.remainingBudget != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'إجمالي التكلفة',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${message.totalCost} ريال',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 20,
                                  width: 1,
                                  color: Colors.grey.shade400,
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'الميزانية المتبقية',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${message.remainingBudget} ريال',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: message.remainingBudget! > 0 ? Colors.green : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
                // وقت الرسالة
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                  child: Text(
                    _getTime(),
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, size: 16, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  String _getTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
// كارد الخدمة
class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey.shade50,
              child: service.image.isNotEmpty
                  ? Image.network(
                'http://127.0.0.1:8088/roqsal_frha_flutter_admin_2026/image/shop/${service.image}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade50,
                    child: Icon(Icons.image_not_supported, color: Colors.grey.shade400, size: 30),
                  );
                },
              )
                  : Container(
                color: Colors.grey.shade50,
                child: Icon(Icons.photo, color: Colors.grey.shade400, size: 30),
              ),
            ),
          ),

          // تفاصيل الخدمة
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم القسم
                Text(
                  service.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),
                // اسم الخدمة
                Text(
                  service.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // الموقع
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey.shade400, size: 12),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        service.address,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // التقييم
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amberAccent, size: 12),
                    const SizedBox(width: 2),
                    Text(
                      service.rating,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // السعر
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    ' ${service.price} ريال',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // رابط عرض التفاصيل

                InkWell(
                  child: Text(
                    'عرض التفاصيل',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}