import 'package:the_alphermix/models/concept_input.dart';
import 'package:the_alphermix/models/fusion_result.dart';
import 'package:the_alphermix/services/openai_service.dart';
import 'package:the_alphermix/services/replicate_service.dart';
import 'package:the_alphermix/services/perplexity_service.dart';
import 'package:the_alphermix/services/storage_service.dart';
import 'package:flutter/foundation.dart';

class FusionOrchestrator {
  final OpenAIService openaiService;
  final ReplicateService replicateService;
  final PerplexityService perplexityService;
  final StorageService storageService;

  FusionOrchestrator({
    required this.openaiService,
    required this.replicateService,
    required this.perplexityService,
    required this.storageService,
  });

  Future<FusionResult?> fuseConcepts(
    ConceptInput input,
    Function(String stage, double progress) onProgress,
  ) async {
    try {
      onProgress('Analyzing concepts...', 0.1);
      await Future.delayed(const Duration(seconds: 2));

      onProgress('Blending ideas...', 0.25);
      final fusionData = await openaiService.fuseConcepts(
        input.conceptA,
        input.conceptADetails,
        input.conceptB,
        input.conceptBDetails,
      );

      if (fusionData == null) {
        debugPrint('Failed to fuse concepts with OpenAI');
        return null;
      }

      onProgress('Researching uniqueness...', 0.50);
      final uniquenessData = await perplexityService.checkUniqueness(
        fusionData['conceptName']!,
        fusionData['description']!,
      );

      onProgress('Creating logo...', 0.70);
      final logoUrl = await replicateService.generateImage(
        '${fusionData['conceptName']}, ${fusionData['tagline']}',
        isLogo: true,
      );

      onProgress('Designing banner...', 0.85);
      final bannerUrl = await replicateService.generateImage(
        '${fusionData['conceptName']}, ${fusionData['description']?.substring(0, 100)}',
        isLogo: false,
      );

      onProgress('Finalizing...', 0.95);
      
      final result = FusionResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conceptName: fusionData['conceptName']!,
        tagline: fusionData['tagline']!,
        elevatorPitch: fusionData['elevatorPitch']!,
        description: fusionData['description']!,
        businessPlan: fusionData['businessPlan']!,
        logoUrl: logoUrl,
        bannerUrl: bannerUrl,
        uniquenessScore: uniquenessData?['uniquenessScore'] ?? 'N/A',
        similarConcepts: uniquenessData?['similarConcepts'] ?? [],
        inputConceptA: input.conceptA,
        inputConceptB: input.conceptB,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await storageService.saveFusionResult(result);
      onProgress('Complete!', 1.0);
      
      return result;
    } catch (e) {
      debugPrint('Fusion Orchestrator Error: $e');
      return null;
    }
  }
}
