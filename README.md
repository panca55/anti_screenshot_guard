# Anti Screenshot Guard

[![pub package](https://img.shields.io/pub/v/anti_screenshot_guard.svg)](https://pub.dev/packages/anti_screenshot_guard)
[![likes](https://img.shields.io/pub/likes/anti_screenshot_guard)](https://pub.dev/packages/anti_screenshot_guard/score)
[![popularity](https://img.shields.io/pub/popularity/anti_screenshot_guard)](https://pub.dev/packages/anti_screenshot_guard/score)
[![points](https://img.shields.io/pub/points/anti_screenshot_guard)](https://pub.dev/packages/anti_screenshot_guard/score)
[![license](https://img.shields.io/github/license/panca55/anti_screenshot_guard)](https://github.com/panca55/anti_screenshot_guard/blob/main/LICENSE)

A Flutter plugin to prevent screenshots and detect screenshot events on Android and iOS.

## Platform Support

| Platform | Screenshot Prevention | Screenshot Detection |
|----------|----------------------|----------------------|
| Android  | ✅ FLAG_SECURE       | ❌ Not needed       |
| iOS      | ❌ Not possible      | ✅ Notification     |

### Android Behavior
- Uses `WindowManager.LayoutParams.FLAG_SECURE` to prevent screenshots and screen recordings
- Prevents recent apps preview capture
- Can be enabled/disabled dynamically per screen

### iOS Behavior
- **Screenshot prevention is NOT possible** due to Apple platform limitations
- Detects screenshot events using `UIApplication.userDidTakeScreenshotNotification`
- Allows UI mitigation (blur, overlay, callback) when screenshot is detected

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  anti_screenshot_guard: ^1.0.2
```

## Usage

### Basic API

```dart
import 'package:anti_screenshot_guard/anti_screenshot_guard.dart';

// Enable screenshot protection
await AntiScreenshotGuard.enable();

// Disable screenshot protection
await AntiScreenshotGuard.disable();

// Check if protection is enabled
bool enabled = await AntiScreenshotGuard.isEnabled;

// Listen for screenshot events
AntiScreenshotGuard.addScreenshotListener(() {
  print('Screenshot detected!');
});

// Remove listener
AntiScreenshotGuard.removeScreenshotListener(callback);
```

### SecureScreen Widget

```dart
SecureScreen(
  enableProtection: true,
  blurOnScreenshot: true,
  onScreenshot: () {
    // Handle screenshot event
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Screenshot Detected'),
        content: Text('Please do not take screenshots of sensitive content.'),
      ),
    );
  },
  child: Container(
    child: Text('Sensitive content here'),
  ),
)
```

## iOS Limitations Warning

⚠️ **Important**: On iOS, it is impossible to prevent screenshots due to platform restrictions imposed by Apple. Attempting to block screenshots would violate Apple's App Store guidelines and may result in app rejection.

The plugin provides detection capabilities on iOS so you can:
- Show warnings to users
- Blur sensitive content temporarily
- Log screenshot attempts
- Implement other mitigation strategies

## Example

See the `example` directory for a complete Flutter app demonstrating the plugin's features.

## Author

**Panca Nugraha**

## Support the author ❤️

Saweria:  
https://saweria.co/pancanugraha

Buy Me a Coffee:  
https://buymeacoffee.com/pancanugraha
