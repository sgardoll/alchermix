import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_alchermix/models/fusion_result.dart';
import 'package:the_alchermix/screens/concept_lab_screen.dart';
import 'package:the_alchermix/utils/constants.dart';
import 'package:the_alchermix/utils/haptic_feedback.dart';

class ResultsDashboardScreen extends StatefulWidget {
  final FusionResult result;

  const ResultsDashboardScreen({super.key, required this.result});

  @override
  State<ResultsDashboardScreen> createState() => _ResultsDashboardScreenState();
}

class _ResultsDashboardScreenState extends State<ResultsDashboardScreen> {
  final _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 300 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset <= 300 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text, String label) {
    HapticHelper.light();
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label copied to clipboard'), duration: const Duration(seconds: 2)),
    );
  }

  void _scrollToTop() {
    HapticHelper.light();
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              HapticHelper.light();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => const ConceptLabScreen()),
                                (route) => false,
                              );
                            },
                          ),
                          const Spacer(),
                          const Icon(Icons.celebration, color: Colors.amber, size: 28),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: AppConstants.getFusionGradient(context),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'YOUR INNOVATION',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.2, end: 0),
                          
                          const SizedBox(height: 16),
                          
                          Text(
                            widget.result.conceptName,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ).animate().fadeIn(delay: 200.ms).scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1, 1),
                            curve: Curves.elasticOut,
                            duration: 800.ms,
                          ),
                          
                          const SizedBox(height: 12),
                          
                          Text(
                            widget.result.tagline,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontStyle: FontStyle.italic,
                            ),
                          ).animate().fadeIn(delay: 300.ms),
                          
                          const SizedBox(height: 24),
                          
                          Row(
                            children: [
                              _InfoChip(
                                icon: Icons.verified,
                                label: 'Uniqueness: ${widget.result.uniquenessScore}',
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              const SizedBox(width: 12),
                              _InfoChip(
                                icon: Icons.merge,
                                label: '${widget.result.inputConceptA} + ${widget.result.inputConceptB}',
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ],
                          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    if (widget.result.logoUrl != null)
                      _AssetCard(
                        title: 'Logo',
                        imageUrl: widget.result.logoUrl!,
                        onCopy: () => _copyToClipboard(widget.result.logoUrl!, 'Logo URL'),
                      ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    if (widget.result.bannerUrl != null)
                      _AssetCard(
                        title: 'Banner',
                        imageUrl: widget.result.bannerUrl!,
                        onCopy: () => _copyToClipboard(widget.result.bannerUrl!, 'Banner URL'),
                      ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    _ExpandableSection(
                      title: '🎯 Elevator Pitch',
                      content: widget.result.elevatorPitch,
                      onCopy: () => _copyToClipboard(widget.result.elevatorPitch, 'Elevator Pitch'),
                    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    _ExpandableSection(
                      title: '📄 Description',
                      content: widget.result.description,
                      onCopy: () => _copyToClipboard(widget.result.description, 'Description'),
                    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    _ExpandableSection(
                      title: '📊 Business Plan',
                      content: widget.result.businessPlan,
                      onCopy: () => _copyToClipboard(widget.result.businessPlan, 'Business Plan'),
                    ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.2, end: 0),
                    
                    if (widget.result.similarConcepts.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _ExpandableSection(
                        title: '🔍 Similar Concepts',
                        content: widget.result.similarConcepts.map((c) => '• $c').join('\n'),
                        onCopy: () => _copyToClipboard(widget.result.similarConcepts.join(', '), 'Similar Concepts'),
                      ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2, end: 0),
                    ],
                    
                    const SizedBox(height: 32),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HapticHelper.medium();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const ConceptLabScreen()),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text('Create Another Fusion'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ).animate().fadeIn(delay: 1100.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
                    
                    const SizedBox(height: 48),
                  ],
                ),
              ),
              
              if (_showBackToTop)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    onPressed: _scrollToTop,
                    mini: true,
                    child: const Icon(Icons.arrow_upward),
                  ).animate().fadeIn().scale(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onCopy;

  const _AssetCard({required this.title, required this.imageUrl, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: onCopy,
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  height: 200,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.image_not_supported, size: 48)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableSection extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onCopy;

  const _ExpandableSection({required this.title, required this.content, required this.onCopy});

  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                HapticHelper.selection();
                setState(() => _isExpanded = !_isExpanded);
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20),
                      onPressed: widget.onCopy,
                    ),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  widget.content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
                ),
              ),
              crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
