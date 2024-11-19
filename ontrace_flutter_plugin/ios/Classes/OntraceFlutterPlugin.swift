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
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                swiftUIView = OntraceView(onComplete: { text in
                    self.sendOnCompleteToFlutter(text: text)
                    self.rootViewControllerG?.dismiss(animated: true)
                    self.hostingController?.dismiss(animated: true)
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
        channel?.invokeMethod("receiveTextFromSwiftUI", arguments: text)
    }

    private func sendOnMessageToFlutter(text: String) {
        print("sendOnMessageToFlutter \(text)")
        channel?.invokeMethod("receiveMessageFromSwift", arguments: text)
    }

}

struct OntraceView: View {

    @Environment(\.presentationMode) var presentationMode
    @State private var text: String = ""
    
    var onComplete: (String) -> Void
    var onMessage: (String) -> Void
    
    var body: some View {
         VStack {
            AnyView(IdentificationFlow.startFlow(apiKey: "1FCBAD86-98AD-4C75-9D36-DE0C383EB9C4",
                                                 onMessage: onMessage,
                                                 onComplete: { result in
                print("result is cancel with error and requestID \(result)")
                switch result {
                    case .success(let requestId, let message):
                        onComplete(requestId)
                        print("result is success with requestID \(result)")
                    case .failure(let requestId, let error):
                        onComplete(error.localizedDescription)
                        print("result is failure with error and requestID \(result)")
                    case .cancel(let requestId, let error):
                        onComplete(error.localizedDescription)
                        print("result is cancel with error and requestID \(result)")
                        
                    @unknown default:
                        fatalError("Unknown result case")
                }
                presentationMode.wrappedValue.dismiss()
            }))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .ignoresSafeArea()
        }
        .padding()
    }
}
