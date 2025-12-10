import 'dart:math';
import 'package:flutter/material.dart';
import 'package:the_alchermix/models/concept_input.dart';
import 'package:the_alchermix/services/fusion_orchestrator.dart';
import 'package:the_alchermix/services/storage_service.dart';
import 'package:the_alchermix/services/openai_service.dart';
import 'package:the_alchermix/services/replicate_service.dart';
import 'package:the_alchermix/services/perplexity_service.dart';
import 'package:the_alchermix/screens/results_dashboard_screen.dart';
import 'package:the_alchermix/utils/constants.dart';
import 'package:the_alchermix/utils/haptic_feedback.dart';

class FusionProcessingScreen extends StatefulWidget {
  final ConceptInput input;

  const FusionProcessingScreen({super.key, required this.input});

  @override
  State<FusionProcessingScreen> createState() => _FusionProcessingScreenState();
}

class _FusionProcessingScreenState extends State<FusionProcessingScreen> with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _mergeController;
  double _progress = 0.0;
  String _currentStage = 'Initializing...';
  String _currentFact = AppConstants.funFacts[0];
  int _factIndex = 0;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    
    _mergeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _rotateFacts();
    _startFusion();
  }

  void _rotateFacts() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 8));
      if (mounted) {
        setState(() {
          _factIndex = (_factIndex + 1) % AppConstants.funFacts.length;
          _currentFact = AppConstants.funFacts[_factIndex];
        });
      }
    }
  }

  void _startFusion() async {
    final storage = StorageService();
    final user = await storage.getUser();
    
    if (user == null || !user.hasAllApiKeys) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('API keys not configured')),
        );
        Navigator.of(context).pop();
      }
      return;
    }

    final orchestrator = FusionOrchestrator(
      openaiService: OpenAIService(user.openaiApiKey!),
      replicateService: ReplicateService(user.replicateApiKey!),
      perplexityService: PerplexityService(user.perplexityApiKey!),
      storageService: storage,
    );

    final result = await orchestrator.fuseConcepts(
      widget.input,
      (stage, progress) {
        if (mounted) {
          setState(() {
            _currentStage = stage;
            _progress = progress;
          });
          if (progress >= 1.0) {
            HapticHelper.successPattern();
          }
        }
      },
    );

    if (!mounted) return;

    if (result != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ResultsDashboardScreen(result: result)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fusion failed. Please check your API keys and try again.')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _particleController.dispose();
    _mergeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppConstants.getFusionGradient(context),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                AnimatedBuilder(
                  animation: _mergeController,
                  builder: (context, child) => CustomPaint(
                    size: const Size(300, 200),
                    painter: _FusionAnimationPainter(
                      progress: _progress,
                      animationValue: _mergeController.value,
                    ),
                  ),
                ),
                
                const SizedBox(height: 60),
                
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 12,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  '${(_progress * 100).toInt()}%',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    _currentStage,
                    key: ValueKey(_currentStage),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const Spacer(),
                
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb_outline, color: Colors.white, size: 28),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            _currentFact,
                            key: ValueKey(_currentFact),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.95),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FusionAnimationPainter extends CustomPainter {
  final double progress;
  final double animationValue;

  _FusionAnimationPainter({required this.progress, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    if (progress < 0.3) {
      paint.color = const Color(0xFF6B4CE6).withValues(alpha: 0.8);
      final offsetA = (1 - progress / 0.3) * 80;
      canvas.drawCircle(
        Offset(centerX - offsetA, centerY),
        40 + sin(animationValue * 2 * pi) * 5,
        paint,
      );
      
      paint.color = const Color(0xFFFF6B9D).withValues(alpha: 0.8);
      final offsetB = (1 - progress / 0.3) * 80;
      canvas.drawCircle(
        Offset(centerX + offsetB, centerY),
        40 + cos(animationValue * 2 * pi) * 5,
        paint,
      );
      
      for (int i = 0; i < 10; i++) {
        final angle = (animationValue + i / 10) * 2 * pi;
        final x = centerX + cos(angle) * (60 + i * 3);
        final y = centerY + sin(angle) * (60 + i * 3);
        paint.color = Colors.white.withValues(alpha: 0.3);
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    } else if (progress < 0.7) {
      final mergeProgress = (progress - 0.3) / 0.4;
      paint.color = Color.lerp(const Color(0xFF6B4CE6), const Color(0xFFFF6B9D), mergeProgress)!.withValues(alpha: 0.9);
      
      final pulseSize = 50 + sin(animationValue * 2 * pi) * 10;
      canvas.drawCircle(Offset(centerX, centerY), pulseSize, paint);
      
      for (int i = 0; i < 20; i++) {
        final angle = (animationValue * 2 + i / 20) * 2 * pi;
        final distance = 70 + cos(animationValue * 3 * pi) * 20;
        final x = centerX + cos(angle) * distance;
        final y = centerY + sin(angle) * distance;
        paint.color = const Color(0xFF00D9FF).withValues(alpha: 0.6);
        canvas.drawCircle(Offset(x, y), 3, paint);
      }
    } else {
      paint.color = const Color(0xFF00D9FF).withValues(alpha: 0.9);
      final finalSize = 60 + sin(animationValue * 2 * pi) * 8;
      canvas.drawCircle(Offset(centerX, centerY), finalSize, paint);
      
      for (int i = 0; i < 30; i++) {
        final angle = (i / 30) * 2 * pi;
        final distance = 80 + (animationValue * 100);
        final x = centerX + cos(angle) * distance;
        final y = centerY + sin(angle) * distance;
        paint.color = Colors.white.withValues(alpha: 0.8 - animationValue * 0.5);
        canvas.drawCircle(Offset(x, y), 4 - animationValue * 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_FusionAnimationPainter oldDelegate) => true;
}
