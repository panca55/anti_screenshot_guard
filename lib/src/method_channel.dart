import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'screenshot_listener.dart';

class AntiScreenshotGuard {
  static const MethodChannel _channel = MethodChannel('anti_screenshot_guard');

  static const EventChannel _eventChannel =
      EventChannel('anti_screenshot_guard_events');

  static Stream<void>? _onScreenshot;

  static bool _initialized = false;

  static void _initialize() {
    if (!_initialized) {
      if (!kIsWeb) {
        _onScreenshot ??=
            _eventChannel.receiveBroadcastStream().map((event) {});
        _onScreenshot!.listen((event) => ScreenshotListener.notifyListeners());
      }
      _initialized = true;
    }
  }

  /// Enable screenshot protection.
  static Future<void> enable() async {
    if (kIsWeb) return;
    _initialize();
    await _channel.invokeMethod('enable');
  }

  /// Disable screenshot protection.
  static Future<void> disable() async {
    if (kIsWeb) return;
    await _channel.invokeMethod('disable');
  }

  /// Check if screenshot protection is enabled.
  static Future<bool> get isEnabled async {
    if (kIsWeb) return false;
    final result = await _channel.invokeMethod('isEnabled');
    return result ?? false;
  }

  /// Add a listener for screenshot events.
  static void addScreenshotListener(ScreenshotCallback callback) {
    _initialize();
    ScreenshotListener.addListener(callback);
  }

  /// Remove a listener for screenshot events.
  static void removeScreenshotListener(ScreenshotCallback callback) {
    ScreenshotListener.removeListener(callback);
  }
}
