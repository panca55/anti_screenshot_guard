import Flutter
import UIKit

public class AntiScreenshotGuardPlugin: NSObject, FlutterPlugin {
  private var eventSink: FlutterEventSink?
  private var screenshotObserver: NSObjectProtocol?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "anti_screenshot_guard", binaryMessenger: registrar.messenger())
    let eventChannel = FlutterEventChannel(name: "anti_screenshot_guard_events", binaryMessenger: registrar.messenger())
    let instance = AntiScreenshotGuardPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    eventChannel.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "enable":
      enableProtection()
      result(nil)
    case "disable":
      disableProtection()
      result(nil)
    case "isEnabled":
      result(false) // iOS doesn't support enabling/disabling screenshot prevention
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func enableProtection() {
    if screenshotObserver == nil {
      screenshotObserver = NotificationCenter.default.addObserver(
        forName: UIApplication.userDidTakeScreenshotNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.eventSink?(nil)
      }
    }
  }

  private func disableProtection() {
    if let observer = screenshotObserver {
      NotificationCenter.default.removeObserver(observer)
      screenshotObserver = nil
    }
  }
}

extension AntiScreenshotGuardPlugin: FlutterStreamHandler {
  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }
}