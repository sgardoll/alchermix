import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:the_alchermix/utils/constants.dart';

class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  final bool isFocused;

  const GlassmorphicCard({super.key, required this.child, this.isFocused = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.mediumAnimation,
      curve: Curves.easeInOut,
      transform: Matrix4.identity()..scale(isFocused ? 1.02 : 1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(AppConstants.cardPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              border: Border.all(
                color: isFocused
                  ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.6)
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
                width: isFocused ? 2 : 1,
              ),
              boxShadow: isFocused
                ? [AppConstants.getGlowShadow(Theme.of(context).colorScheme.primary)]
                : [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
