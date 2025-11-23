import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ReplicateService {
  final String apiKey;
  static const String _baseUrl = 'https://api.replicate.com/v1/predictions';

  ReplicateService(this.apiKey);

  Future<String?> generateImage(String prompt, {bool isLogo = true}) async {
    try {
      final enhancedPrompt = isLogo
        ? 'Professional minimalist logo design, $prompt, clean vector style, white background, modern, simple, iconic'
        : 'Professional business banner image, $prompt, modern design, high quality, vibrant colors, appealing composition';

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'version': 'stability-ai/sdxl:39ed52f2a78e934b3ba6e2a89f5b1c712de7dfea535525255b1aa35c5565e08b',
          'input': {
            'prompt': enhancedPrompt,
            'negative_prompt': 'blurry, low quality, distorted, ugly, watermark, text',
            'width': isLogo ? 512 : 1024,
            'height': isLogo ? 512 : 512,
            'num_outputs': 1,
          }
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final predictionId = data['id'] as String;
        return await _pollForResult(predictionId);
      } else {
        debugPrint('Replicate API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Replicate Service Error: $e');
      return null;
    }
  }

  Future<String?> _pollForResult(String predictionId) async {
    for (int i = 0; i < 30; i++) {
      await Future.delayed(const Duration(seconds: 2));
      try {
        final response = await http.get(
          Uri.parse('$_baseUrl/$predictionId'),
          headers: {'Authorization': 'Bearer $apiKey'},
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          final status = data['status'] as String;
          
          if (status == 'succeeded') {
            final output = data['output'] as List<dynamic>;
            return output.first as String;
          } else if (status == 'failed') {
            debugPrint('Replicate prediction failed');
            return null;
          }
        }
      } catch (e) {
        debugPrint('Polling error: $e');
      }
    }
    debugPrint('Replicate polling timeout');
    return null;
  }
}
