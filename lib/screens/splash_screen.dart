import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_alphermix/utils/constants.dart';
import 'package:the_alphermix/screens/api_setup_screen.dart';
import 'package:the_alphermix/screens/concept_lab_screen.dart';
import 'package:the_alphermix/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    
    final user = await _storageService.getUser();
    final hasApiKeys = user?.hasAllApiKeys ?? false;
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
          hasApiKeys ? const ConceptLabScreen() : const ApiSetupScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppConstants.getFusionGradient(context),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.auto_awesome,
                size: 120,
                color: Colors.white,
              ).animate()
                .scale(begin: const Offset(0, 0), end: const Offset(1.2, 1.2), duration: 400.ms, curve: Curves.elasticOut)
                .then()
                .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1), duration: 200.ms),
              
              const SizedBox(height: 40),
              
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),
              
              const SizedBox(height: 16),
              
              _TypewriterText(
                text: AppConstants.tagline,
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  letterSpacing: 1,
                ),
              ).animate(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;

  const _TypewriterText({required this.text, this.textStyle});

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText> {
  String _displayText = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    for (int i = 0; i < widget.text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (mounted) {
        setState(() {
          _currentIndex = i + 1;
          _displayText = widget.text.substring(0, _currentIndex);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => Text(_displayText, style: widget.textStyle);
}
