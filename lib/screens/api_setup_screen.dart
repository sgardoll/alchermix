import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_alchermix/models/user.dart';
import 'package:the_alchermix/services/storage_service.dart';
import 'package:the_alchermix/screens/concept_lab_screen.dart';
import 'package:the_alchermix/utils/constants.dart';
import 'package:the_alchermix/utils/haptic_feedback.dart';
import 'package:the_alchermix/theme.dart';

class ApiSetupScreen extends StatefulWidget {
  const ApiSetupScreen({super.key});

  @override
  State<ApiSetupScreen> createState() => _ApiSetupScreenState();
}

class _ApiSetupScreenState extends State<ApiSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _openaiController = TextEditingController();
  final _replicateController = TextEditingController();
  final _perplexityController = TextEditingController();
  final StorageService _storageService = StorageService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadExistingKeys();
  }

  void _loadExistingKeys() async {
    final user = await _storageService.getUser();
    if (user != null && mounted) {
      setState(() {
        _openaiController.text = user.openaiApiKey ?? '';
        _replicateController.text = user.replicateApiKey ?? '';
        _perplexityController.text = user.perplexityApiKey ?? '';
      });
    }
  }

  void _saveAndContinue() async {
    if (!_formKey.currentState!.validate()) return;
    
    HapticHelper.medium();
    setState(() => _isLoading = true);

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'User',
      email: 'user@conceptfusion.app',
      openaiApiKey: _openaiController.text.trim(),
      replicateApiKey: _replicateController.text.trim(),
      perplexityApiKey: _perplexityController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _storageService.saveUser(user);
    
    if (!mounted) return;
    HapticHelper.successPattern();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ConceptLabScreen()),
    );
  }

  @override
  void dispose() {
    _openaiController.dispose();
    _replicateController.dispose();
    _perplexityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientTheme = Theme.of(context).extension<FusionGradientTheme>();
    final onGradient = gradientTheme?.onGradient ?? Theme.of(context).colorScheme.onPrimary;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppConstants.getFusionGradient(context),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Icon(Icons.key, size: 80, color: onGradient).animate()
                    .scale(duration: 600.ms, curve: Curves.elasticOut),
                  const SizedBox(height: 24),
                  Text(
                    'API Configuration',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(color: onGradient, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 12),
                  Text(
                    'Enter your API keys to unlock the fusion magic',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: onGradient.withValues(alpha: 0.9)),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 48),
                  
                  _ApiKeyField(
                    controller: _openaiController,
                    label: 'OpenAI API Key',
                    hint: 'sk-...',
                    icon: Icons.psychology,
                  ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2, end: 0),
                  
                  const SizedBox(height: 20),
                  
                  _ApiKeyField(
                    controller: _replicateController,
                    label: 'Replicate API Key',
                    hint: 'r8_...',
                    icon: Icons.image,
                  ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2, end: 0),
                  
                  const SizedBox(height: 20),
                  
                  _ApiKeyField(
                    controller: _perplexityController,
                    label: 'Perplexity API Key',
                    hint: 'pplx-...',
                    icon: Icons.search,
                  ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2, end: 0),
                  
                  const SizedBox(height: 40),
                  
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveAndContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                    ),
                    child: _isLoading
                      ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text('Continue to Fusion Lab', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ).animate().fadeIn(delay: 700.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    '🔒 Your API keys are stored securely on device',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: onGradient.withValues(alpha: 0.8)),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 800.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ApiKeyField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  const _ApiKeyField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final gradientTheme = Theme.of(context).extension<FusionGradientTheme>();
    final onGradient = gradientTheme?.onGradient ?? Theme.of(context).colorScheme.onPrimary;
    return Container(
      decoration: BoxDecoration(
        color: onGradient.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: onGradient.withValues(alpha: 0.3)),
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: onGradient),
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: onGradient.withValues(alpha: 0.9)),
          hintStyle: TextStyle(color: onGradient.withValues(alpha: 0.5)),
          prefixIcon: Icon(icon, color: onGradient.withValues(alpha: 0.9)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }
}
