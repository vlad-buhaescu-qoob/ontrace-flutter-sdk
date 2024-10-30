import Flutter
import UIKit
import SwiftUI

public class OntraceFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ontrace_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = OntraceFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "startIOSActivity":
      showSwiftUIView()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

    private func showSwiftUIView() {
        DispatchQueue.main.async {
            let ontraceView = OntraceView()
            let hostingController = UIHostingController(rootView: ontraceView)
            hostingController.modalPresentationStyle = .fullScreen
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                rootViewController.present(hostingController, animated: false, completion: nil)
            }
        }
    }

}

struct OntraceView: View {
    var body: some View {
      //To be replaced with OntraceSDK
        VStack {
            Text("Hello from SwiftUI!")
                .font(.largeTitle)
                .padding()
        }
    }
}