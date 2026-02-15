typedef ScreenshotCallback = void Function();

class ScreenshotListener {
  static final Set<ScreenshotCallback> _listeners = {};

  static void addListener(ScreenshotCallback callback) {
    _listeners.add(callback);
  }

  static void removeListener(ScreenshotCallback callback) {
    _listeners.remove(callback);
  }

  static void notifyListeners() {
    for (final callback in _listeners) {
      callback();
    }
  }
}
