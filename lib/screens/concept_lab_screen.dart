import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_alchermix/models/concept_input.dart';
import 'package:the_alchermix/screens/fusion_processing_screen.dart';
import 'package:the_alchermix/screens/api_setup_screen.dart';
import 'package:the_alchermix/screens/history_screen.dart';
import 'package:the_alchermix/utils/constants.dart';
import 'package:the_alchermix/utils/haptic_feedback.dart';
import 'package:the_alchermix/widgets/glassmorphic_card.dart';
import 'package:the_alchermix/widgets/fusion_button.dart';
import 'package:the_alchermix/theme.dart';

class ConceptLabScreen extends StatefulWidget {
  const ConceptLabScreen({super.key});

  @override
  State<ConceptLabScreen> createState() => _ConceptLabScreenState();
}

class _ConceptLabScreenState extends State<ConceptLabScreen>
    with TickerProviderStateMixin {
  final _conceptAController = TextEditingController();
  final _conceptADetailsController = TextEditingController();
  final _conceptBController = TextEditingController();
  final _conceptBDetailsController = TextEditingController();

  bool _showDetailsA = false;
  bool _showDetailsB = false;
  bool _isConceptAFocused = false;
  bool _isConceptBFocused = false;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _conceptAController.dispose();
    _conceptADetailsController.dispose();
    _conceptBController.dispose();
    _conceptBDetailsController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _conceptAController.text.trim().isNotEmpty &&
      _conceptBController.text.trim().isNotEmpty;

  void _fuseConcepts() {
    if (!_isValid) return;

    HapticHelper.medium();
    final input = ConceptInput(
      conceptA: _conceptAController.text.trim(),
      conceptADetails: _conceptADetailsController.text.trim(),
      conceptB: _conceptBController.text.trim(),
      conceptBDetails: _conceptBDetailsController.text.trim(),
      createdAt: DateTime.now(),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => FusionProcessingScreen(input: input)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Align with app-wide gradient to prevent light bottom gaps on tall viewports
          gradient: AppConstants.getFusionGradient(context),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: LightModeColors.lightInversePrimary,
                      ),
                      onPressed: () {
                        HapticHelper.light();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ApiSetupScreen()));
                      },
                    ),
                    Text(
                      " Fusion Lab",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: LightModeColors.lightInversePrimary,
                              fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.history,
                        color: LightModeColors.lightInversePrimary,
                      ),
                      tooltip: 'History',
                      onPressed: () {
                        HapticHelper.light();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const HistoryScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GlassmorphicCard(
                                  isFocused: _isConceptAFocused,
                                  child:
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text('CONCEPT A',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.5)),
                                        const SizedBox(height: 16),
                                        Focus(
                                            onFocusChange: (focused) {
                                              setState(() =>
                                                  _isConceptAFocused = focused);
                                              if (focused)
                                                HapticHelper.selection();
                                            },
                                            child: TextField(
                                                controller: _conceptAController,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Theme.of(context)
                                                                    .colorScheme
                                                                    .primary,
                                                            width: 2)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(12),
                                                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3))),
                                                    hintText: "e.g., food"),
                                                onChanged: (_) => setState(() {}))),
                                        const SizedBox(height: 12),
                                        TextButton.icon(
                                            onPressed: () {
                                              HapticHelper.light();
                                              setState(() => _showDetailsA =
                                                  !_showDetailsA);
                                            },
                                            icon: Icon(
                                                _showDetailsA
                                                    ? Icons.remove
                                                    : Icons.add,
                                                size: 18),
                                            label: const Text(
                                                'Optional: Add details')),
                                        if (_showDetailsA) ...[
                                          const SizedBox(height: 12),
                                          TextField(
                                                  controller:
                                                      _conceptADetailsController,
                                                  maxLines: 3,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'Additional context...',
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              16)))
                                              .animate()
                                              .fadeIn(duration: 300.ms)
                                              .slideY(begin: -0.1, end: 0)
                                        ]
                                      ]))
                              .animate()
                              .fadeIn(duration: 500.ms)
                              .scale(
                                  begin: const Offset(0.95, 0.95),
                                  end: const Offset(1.0, 1.0),
                                  duration: 500.ms)
                              .animate()
                              .fadeIn(delay: 100.ms, duration: 500.ms)
                              .slideY(
                                  begin: 0.2, end: 0, curve: Curves.elasticOut),
                          const SizedBox(height: 32),
                          AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                final scale =
                                    1.0 + (_pulseController.value * 0.1);
                                return Transform.scale(
                                    scale: scale,
                                    child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(boxShadow: [
                                          AppConstants.getGlowShadow(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary)
                                        ], shape: BoxShape.circle),
                                        child: const Icon(Icons.flash_on,
                                            color: Colors.white, size: 32)));
                              }),
                          const SizedBox(height: 32),
                          GlassmorphicCard(
                                  isFocused: false,
                                  child:
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text('CONCEPT B',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.5)),
                                        const SizedBox(height: 16),
                                        Focus(
                                            onFocusChange: (focused) {
                                              setState(() =>
                                                  _isConceptBFocused = focused);
                                              if (focused)
                                                HapticHelper.selection();
                                            },
                                            child: TextField(
                                                controller: _conceptBController,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Theme.of(context)
                                                                    .colorScheme
                                                                    .secondary,
                                                            width: 2)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(12),
                                                        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3))),
                                                    hintText: "e.g., fitness"),
                                                onChanged: (_) => setState(() {}))),
                                        const SizedBox(height: 12),
                                        TextButton.icon(
                                            onPressed: () {
                                              HapticHelper.light();
                                              setState(() => _showDetailsB =
                                                  !_showDetailsB);
                                            },
                                            icon: Icon(
                                                _showDetailsB
                                                    ? Icons.remove
                                                    : Icons.add,
                                                size: 18),
                                            label: const Text(
                                                'Optional: Add details')),
                                        if (_showDetailsB) ...[
                                          const SizedBox(height: 12),
                                          TextField(
                                                  controller:
                                                      _conceptBDetailsController,
                                                  maxLines: 3,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'Additional context...',
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              16)))
                                              .animate()
                                              .fadeIn(duration: 300.ms)
                                              .slideY(begin: -0.1, end: 0)
                                        ]
                                      ]))
                              .animate()
                              .fadeIn(delay: 250.ms, duration: 500.ms)
                              .slideY(
                                  begin: 0.2, end: 0, curve: Curves.elasticOut),
                          const SizedBox(height: 48),
                          FusionButton(
                                  isEnabled: _isValid, onPressed: _fuseConcepts)
                              .animate()
                              .fadeIn(
                                  delay: 250.ms,
                                  duration: 380.ms,
                                  curve: Curves.easeOutCubic)
                              .slideY(
                                  begin: 0.08,
                                  end: 0,
                                  duration: 420.ms,
                                  curve: Curves.easeOutCubic),
                          const SizedBox(height: 24)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
