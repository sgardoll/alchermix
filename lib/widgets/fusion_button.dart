import 'package:flutter/material.dart';
import 'package:the_alchermix/utils/constants.dart';

class FusionButton extends StatefulWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const FusionButton({super.key, required this.isEnabled, required this.onPressed});

  @override
  State<FusionButton> createState() => _FusionButtonState();
}

class _FusionButtonState extends State<FusionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.isEnabled ? (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      } : null,
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: widget.isEnabled
                  ? LinearGradient(
                      begin: Alignment(_controller.value * 2 - 1, 0),
                      end: Alignment(_controller.value * 2, 0),
                      colors: const [Color(0xFF6B4CE6), Color(0xFFFF6B9D), Color(0xFF00D9FF)],
                    )
                  : LinearGradient(colors: [Colors.grey.shade400, Colors.grey.shade500]),
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                boxShadow: widget.isEnabled
                  ? [AppConstants.getGlowShadow(Theme.of(context).colorScheme.primary)]
                  : [],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    'FUSE CONCEPTS',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
