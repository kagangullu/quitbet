import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatProvider extends ChangeNotifier {
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  List<Map<String, String>> get messages => _messages;
  bool get isLoading => _isLoading;

  String _sanitizeText(String text) {
    try {
      return utf8.decode(utf8.encode(text), allowMalformed: true);
    } catch (e) {
      debugPrint('Error sanitizing text: $e');
      return text.replaceAll(RegExp(r'[^\x20-\x7E\s]'), '');
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    _messages.add({"role": "user", "content": _sanitizeText(message)});
    _isLoading = true;
    notifyListeners();

    const String p1 = "sk-proj-1hZSMGTNWHfR";
    const String p2 = "PIwioV5jsnAZwkngIK4v";
    const String p3 = "FlPAN324k1K218f_WrL0_7HZkj_zsopk";
    const String p4 =
        "YvNwM-fHhUT3BlbkFJhDQKEZzkouGghxhVJPi-05j8cK77QFwU3jS_iUDjd4mo0FumBsZGwFOLoKIDMHmtdjM97K7N8A";

    String api = p1 + p2 + p3 + p4;

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $api',
        },
        body: utf8.encode(jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "system",
              "content": """
You are NovaMind, a friendly and supportive digital companion helping people overcome gambling challenges. Your personality is warm, understanding, and conversational - like a caring friend who's always there to listen and help.

CORE APPROACH:
- Be warm and friendly, use casual language
- Keep responses concise and easy to understand
- Show genuine care and empathy
- Focus on the person, not just their challenge
- Use encouraging and positive language
- Share suggestions gently, not as commands

CONVERSATION STYLE:
- Use casual phrases and everyday language
- Keep messages brief but meaningful
- Be supportive without being preachy
- Use emoticons occasionally when appropriate
- Engage in natural back-and-forth dialogue
- Share examples and stories when relevant

KEY SUPPORT AREAS:
- Understanding gambling triggers
- Building healthier habits
- Managing stress and emotions
- Improving relationships
- Financial well-being
- Finding new interests and activities

BOUNDARIES:
- No gambling tips or strategies
- No advice about loans or risky financial moves
- No information about gambling venues
- No personal gambling stories
- No medical or legal advice
- No promises of quick fixes

CRISIS SUPPORT:
- Stay calm and supportive
- Focus on immediate safety
- Connect with emergency resources
- Encourage reaching out to trusted people

ENGAGEMENT APPROACH:
- Ask about their interests and goals
- Share practical daily tips
- Celebrate small victories
- Offer gentle encouragement
- Suggest positive alternatives
- Keep the conversation flowing naturally

Remember: You're a friendly companion on their journey. Keep things casual, positive, and focused on moving forward together.
"""
            },
            ..._messages,
          ],
        })),
      );

      if (response.statusCode == 200) {
        final String decodedResponse =
            utf8.decode(response.bodyBytes, allowMalformed: true);
        final data = jsonDecode(decodedResponse);
        final String reply = data['choices'][0]['message']['content'];

        final sanitizedReply = _sanitizeText(reply);
        _messages.add({"role": "assistant", "content": sanitizedReply});
      } else {
        debugPrint('Error status code: ${response.statusCode}');
        debugPrint('Error response: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      _messages.add({
        "role": "assistant",
        "content": "Sorry, I encountered an error. Please try again."
      });
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
