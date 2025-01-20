import Flutter
import UIKit
import SwiftUI
import QoobissCoreIdentificationSDK

public class OntraceFlutterPlugin: NSObject, FlutterPlugin {
    private var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ontrace_flutter_plugin", binaryMessenger: registrar.messenger())
        let instance = OntraceFlutterPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    private var rootViewControllerG: UIViewController?
    private var swiftUIView: OntraceView?
    private var hostingController: UIHostingController<OntraceView?>?
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "startIOSActivity" {
            if let parameters = call.arguments as? [String: String],
               let apiKey = parameters["apiKey"],
               let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                print("parameters sent are \(parameters)")
                swiftUIView = OntraceView(
                    apiKey: apiKey,
                    onComplete: { text in
                        self.sendOnCompleteToFlutter(text: text)
                        self.rootViewControllerG?.dismiss(animated: true)
                        result("wrong step")
                    }, onMessage: { text in
                        print("onMessage is success with requestID \(text)")
                        self.sendOnMessageToFlutter(text: text)
                    })
                hostingController = UIHostingController(rootView: swiftUIView)
                hostingController?.modalPresentationStyle = .fullScreen
                rootViewController.present(hostingController!, animated: false, completion: nil)
                rootViewControllerG = rootViewController
                result(nil)
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func sendOnCompleteToFlutter(text: String) {
        print("sendOnCompleteToFlutter \(text)")
        channel?.invokeMethod("receiveOnComplete", arguments: text)
    }
    
    private func sendOnMessageToFlutter(text: String) {
        print("sendOnMessageToFlutter \(text)")
        channel?.invokeMethod("receiveOnMessage", arguments: text)
    }
    
}

struct OntraceView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var text: String = ""
    
    var apiKey: String
    var onComplete: (String) -> Void
    var onMessage: (String) -> Void
    
    var body: some View {
        VStack {
            AnyView(IdentificationFlow.startFlowCrossPlatform(apiKey: apiKey,
                                                              onMessage: onMessage,
                                                              onComplete: { result in
                onComplete(result)
                presentationMode.wrappedValue.dismiss()
            }))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
            .foregroundColor(.white)
            .ignoresSafeArea()
        }
        .padding()
        .onAppear {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
}
