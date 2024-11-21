import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey =
      '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';
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': message}
        ],
        'max_tokens': 50,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to load AI response');
    }
  }
}
