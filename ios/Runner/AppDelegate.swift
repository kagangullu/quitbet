import Flutter
import UIKit
import SafariServices
import WidgetKit

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
        
        // Widget'ları güncelle (iOS 14 ve üzeri)
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        super.applicationWillEnterForeground(application)
        
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application)
        
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
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