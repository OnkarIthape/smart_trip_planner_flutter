import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  static final _apiKey = dotenv.env['OPENAI_API_KEY'];
  static const _url = 'https://api.openai.com/v1/chat/completions';

  static Stream<String> streamItinerary(String prompt) async* {
    final request = http.Request('POST', Uri.parse(_url))
      ..headers.addAll({
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      })
      ..body = jsonEncode({
        "model": "gpt-4", // or "gpt-3.5-turbo"
        "temperature": 0.7,
        "stream": true,
        "messages": [
          {"role": "system", "content": "You are a smart travel agent that generates JSON trip itineraries."},
          {"role": "user", "content": prompt}
        ],
      });

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Stream Error: ${response.statusCode}");
    }

    final stream = response.stream.transform(utf8.decoder);
    await for (final chunk in stream) {
      final lines = chunk.split('\n');
      for (var line in lines) {
        if (line.trim().isEmpty || !line.startsWith('data:')) continue;
        final payload = line.replaceFirst('data: ', '').trim();
        if (payload == '[DONE]') break;

        final data = jsonDecode(payload);
        final delta = data['choices'][0]['delta'];
        if (delta != null && delta['content'] != null) {
          yield delta['content'];
        }
      }
    }
  }
}
