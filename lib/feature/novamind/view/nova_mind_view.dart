import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quit_gambling/product/services/nova_mind_provider.dart';

class NovaMindView extends StatefulWidget {
  const NovaMindView({super.key});

  @override
  State<NovaMindView> createState() => _NovaMindViewState();
}

class _NovaMindViewState extends State<NovaMindView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: const Color(0xff060724),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
        title: Column(
          children: [
            const Text(
              'QUITTR Therapy',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Powered by AI',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    if (chatProvider.messages.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isKeyboardVisible)
                              Lottie.asset("assets/lottie/light.json"),
                            const SizedBox(height: 20),
                            const Text(
                              'Talk to Melius',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Chat messages are cleared each time you\nleave this view to ensure your privacy.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    _scrollToBottom();
                    return GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: chatProvider.messages.length,
                        itemBuilder: (context, index) {
                          final message = chatProvider.messages[index];
                          final isUser = message["role"] == "user";

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: isUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.75,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isUser
                                          ? const Color(0xffb4b5bd)
                                          : const Color(0xFF2C2C2E),
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20),
                                        topRight: const Radius.circular(20),
                                        bottomLeft:
                                            Radius.circular(isUser ? 20 : 5),
                                        bottomRight:
                                            Radius.circular(isUser ? 5 : 20),
                                      ),
                                    ),
                                    child: Text(
                                      message["content"]!,
                                      style: TextStyle(
                                        color: isUser
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff12133c),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Say something',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        maxLines: null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_controller.text.isNotEmpty) {
                          context
                              .read<ChatProvider>()
                              .sendMessage(_controller.text);
                          _controller.clear();
                          _scrollToBottom();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          CupertinoIcons.arrow_up_circle_fill,
                          color: Colors.white70,
                          size: 28,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
