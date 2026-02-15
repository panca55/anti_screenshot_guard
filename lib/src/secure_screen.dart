import 'dart:ui';
import 'package:flutter/material.dart';
import 'method_channel.dart';

class SecureScreen extends StatefulWidget {
  final bool enableProtection;
  final bool blurOnScreenshot;
  final VoidCallback? onScreenshot;
  final Widget child;

  const SecureScreen({
    super.key,
    this.enableProtection = true,
    this.blurOnScreenshot = false,
    this.onScreenshot,
    required this.child,
  });

  @override
  State<SecureScreen> createState() => _SecureScreenState();
}

class _SecureScreenState extends State<SecureScreen> {
  bool _isBlurred = false;

  @override
  void initState() {
    super.initState();
    if (widget.enableProtection) {
      AntiScreenshotGuard.enable();
    }
    if (widget.onScreenshot != null) {
      AntiScreenshotGuard.addScreenshotListener(_onScreenshotTaken);
    }
  }

  @override
  void didUpdateWidget(SecureScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enableProtection != oldWidget.enableProtection) {
      if (widget.enableProtection) {
        AntiScreenshotGuard.enable();
      } else {
        AntiScreenshotGuard.disable();
      }
    }
  }

  @override
  void dispose() {
    if (widget.enableProtection) {
      AntiScreenshotGuard.disable();
    }
    super.dispose();
  }

  void _onScreenshotTaken() {
    widget.onScreenshot?.call();
    if (widget.blurOnScreenshot) {
      setState(() {
        _isBlurred = true;
      });
      // Optionally, unblur after some time
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isBlurred = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isBlurred)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),
      ],
    );
  }
}
