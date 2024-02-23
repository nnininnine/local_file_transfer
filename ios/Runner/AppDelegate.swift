import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let vc: FlutterViewController = window?.rootViewController as! FlutterViewController
        let myChannel = FlutterMethodChannel(name: "app.local_file_transfer.com/test_channel", binaryMessenger: vc.binaryMessenger)

        myChannel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "helloWorld" {
                result(self.helloWorld())
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func helloWorld() -> String {
        return "Hello World from iOS <3"
    }
}
