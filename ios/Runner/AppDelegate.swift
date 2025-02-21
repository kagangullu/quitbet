import Flutter
import UIKit
import SafariServices

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "com.example.quitbet/content_blocker",
            binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "reloadContentBlocker":
                self?.reloadContentBlocker(result: result)
            case "getContentBlockerStatus":
                self?.getContentBlockerStatus(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func reloadContentBlocker(result: @escaping FlutterResult) {
        SFContentBlockerManager.reloadContentBlocker(
            withIdentifier: "com.example.quitbet.GamblingBlocker") { error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Content Blocker Error: \(error)")
                        result(FlutterError(
                            code: "RELOAD_ERROR",
                            message: error.localizedDescription,
                            details: nil))
                    } else {
                        print("Content Blocker reloaded successfully")
                        result(nil)
                    }
                }
            }
    }
    
    private func getContentBlockerStatus(result: @escaping FlutterResult) {
        SFContentBlockerManager.getStateOfContentBlocker(
            withIdentifier: "com.example.quitbet.GamblingBlocker") { state, error in
                DispatchQueue.main.async {
                    if let error = error {
                        result(FlutterError(
                            code: "STATUS_ERROR",
                            message: error.localizedDescription,
                            details: nil))
                        return
                    }
                    result(state?.isEnabled ?? false)
                }
            }
    }
}