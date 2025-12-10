import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:the_alchermix/utils/constants.dart';
import 'package:the_alchermix/theme.dart';

class FusionButton extends StatefulWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const FusionButton(
      {super.key, required this.isEnabled, required this.onPressed});

  @override
  State<FusionButton> createState() => _FusionButtonState();
}

class _FusionButtonState extends State<FusionButton>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _activateController;
  late Animation<double> _activateAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    // Shimmer controller drives the highlight overlay sweep
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Activation animation: plays once when button becomes enabled
    _activateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _activateAnimation = CurvedAnimation(
      parent: _activateController,
      curve: Curves.easeOutCubic,
    );

    // If already enabled on init, set to completed state and start shimmer
    if (widget.isEnabled) {
      _activateController.value = 1.0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _shimmerController.repeat();
      });
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _activateController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FusionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isEnabled != widget.isEnabled) {
      if (widget.isEnabled) {
        // Play the activation animation when becoming enabled
        _activateController.forward(from: 0.0);
        if (!_shimmerController.isAnimating) {
          _shimmerController.repeat();
        }
      } else {
        _activateController.reverse();
        _shimmerController.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:
          widget.isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed();
            }
          : null,
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        alignment: Alignment.center,
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: AnimatedBuilder(
          animation: Listenable.merge([_shimmerController, _activateAnimation]),
          builder: (context, _) {
            final theme = Theme.of(context);
            final colorScheme = theme.colorScheme;
            final fusion = theme.extension<FusionGradientTheme>();
            final onGradientColor = fusion?.onGradient ?? colorScheme.onPrimary;
            final start = fusion?.gradientStart ?? colorScheme.primary;
            final end = fusion?.gradientEnd ??
                (colorScheme.tertiary ?? colorScheme.primaryContainer);

            // Activation progress (0 = disabled look, 1 = fully enabled)
            final double activateT = _activateAnimation.value;

            // Interpolate colors from disabled to enabled based on activation
            final Color disabledStart =
                Color.lerp(start, colorScheme.surface, 0.45) ?? start;
            final Color disabledEnd =
                Color.lerp(end, colorScheme.surface, 0.45) ?? end;
            final Color currentStart =
                Color.lerp(disabledStart, start, activateT) ?? start;
            final Color currentEnd =
                Color.lerp(disabledEnd, end, activateT) ?? end;

            // Shimmer sweep position from -1.4 to 1.4 alignment X
            final double shimmerT = _shimmerController.value;
            final double sweepX = -1.4 + (2.8 * shimmerT);

            // Glow intensity based on activation
            final double glowOpacity = activateT;

            return Stack(
              alignment: Alignment.center,
              children: [
                // Base button with animated gradient transition
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[currentStart, currentEnd],
                    ),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    boxShadow: glowOpacity > 0
                        ? [
                            BoxShadow(
                              color: colorScheme.primary.withValues(alpha: 0.4 * glowOpacity),
                              blurRadius: 16 * glowOpacity,
                              spreadRadius: 2 * glowOpacity,
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: onGradientColor.withValues(alpha: 0.5 + 0.5 * activateT),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'FUSE CONCEPTS',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: onGradientColor.withValues(alpha: 0.5 + 0.5 * activateT),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Shimmer overlay: fades in with activation
                if (activateT > 0.3)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: ((activateT - 0.3) / 0.7).clamp(0.0, 1.0),
                        child: Align(
                          alignment: Alignment(sweepX, 0),
                          child: FractionallySizedBox(
                            widthFactor: 0.38,
                            heightFactor: 1.2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.0),
                                    Colors.white.withValues(alpha: 0.18),
                                    Colors.white.withValues(alpha: 0.0),
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
