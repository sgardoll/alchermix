import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class OpenAIService {
  final String apiKey;
  static const String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  OpenAIService(this.apiKey);

  Future<Map<String, String>?> fuseConcepts(String conceptA, String conceptADetails, String conceptB, String conceptBDetails) async {
    try {
      final prompt = '''You are an innovative business concept designer. Fuse these two concepts into ONE genuinely novel and unique business idea:

CONCEPT A: $conceptA
${conceptADetails.isNotEmpty ? 'Details: $conceptADetails' : ''}

CONCEPT B: $conceptB
${conceptBDetails.isNotEmpty ? 'Details: $conceptBDetails' : ''}

Create a fusion that combines the best aspects of both concepts in an unexpected, creative way. The result MUST be original and not currently available in the market.

Respond ONLY with valid JSON in this exact format (no markdown, no code blocks):
{
  "conceptName": "catchy name for the fused concept (2-4 words)",
  "tagline": "memorable one-liner hook (max 10 words)",
  "elevatorPitch": "compelling 2-3 sentence pitch that makes someone say 'wow, I need that'",
  "description": "detailed 4-5 paragraph description covering: what it is, how it works, who it's for, why it's unique, and the core value proposition",
  "businessPlan": "comprehensive business plan covering: market analysis, target audience, revenue model, marketing strategy, competition analysis, growth projections, and potential challenges (minimum 6 paragraphs)"
}''';

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o',
          'messages': [
            {'role': 'system', 'content': 'You are a creative business concept innovator. Always respond with valid JSON only.'},
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.9,
          'max_tokens': 3000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final content = data['choices'][0]['message']['content'] as String;
        final cleaned = content.trim().replaceAll('```json', '').replaceAll('```', '').trim();
        final result = jsonDecode(cleaned) as Map<String, dynamic>;
        return {
          'conceptName': result['conceptName'] as String,
          'tagline': result['tagline'] as String,
          'elevatorPitch': result['elevatorPitch'] as String,
          'description': result['description'] as String,
          'businessPlan': result['businessPlan'] as String,
        };
      } else {
        debugPrint('OpenAI API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('OpenAI Service Error: $e');
      return null;
    }
  }
}
