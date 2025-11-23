import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PerplexityService {
  final String apiKey;
  static const String _baseUrl = 'https://api.perplexity.ai/chat/completions';

  PerplexityService(this.apiKey);

  Future<Map<String, dynamic>?> checkUniqueness(String conceptName, String description) async {
    try {
      final prompt = '''Search the web comprehensively for products, services, apps, or businesses similar to this concept:

NAME: $conceptName
DESCRIPTION: $description

Provide:
1. A uniqueness score from 0-100 (100 = completely unique, 0 = already exists exactly)
2. List of 3-5 similar existing products/services (if any)
3. Brief explanation of what makes this concept different or the same

Respond ONLY with valid JSON in this exact format:
{
  "uniquenessScore": "score/100",
  "similarConcepts": ["concept1", "concept2", "concept3"],
  "analysis": "brief explanation"
}''';

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'llama-3.1-sonar-large-128k-online',
          'messages': [
            {'role': 'system', 'content': 'You are a market research analyst. Search the web and respond with valid JSON only.'},
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.2,
          'max_tokens': 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final content = data['choices'][0]['message']['content'] as String;
        final cleaned = content.trim().replaceAll('```json', '').replaceAll('```', '').trim();
        final result = jsonDecode(cleaned) as Map<String, dynamic>;
        return {
          'uniquenessScore': result['uniquenessScore'] as String,
          'similarConcepts': (result['similarConcepts'] as List<dynamic>).map((e) => e as String).toList(),
          'analysis': result['analysis'] as String,
        };
      } else {
        debugPrint('Perplexity API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Perplexity Service Error: $e');
      return null;
    }
  }
}
