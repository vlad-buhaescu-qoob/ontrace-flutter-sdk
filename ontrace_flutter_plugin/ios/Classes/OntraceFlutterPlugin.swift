import Flutter
import UIKit
import SwiftUI

public class OntraceFlutterPlugin: NSObject, FlutterPlugin {
    private var channel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ontrace_flutter_plugin", binaryMessenger: registrar.messenger())
        let instance = OntraceFlutterPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "startIOSActivity" {
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                let swiftUIView = OntraceView(onSubmit: { text in
                    self.sendTextToFlutter(text: text)
                })
                let hostingController = UIHostingController(rootView: swiftUIView)
                hostingController.modalPresentationStyle = .fullScreen 
                rootViewController.present(hostingController, animated: false, completion: nil)
                result(nil)
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func sendTextToFlutter(text: String) {
        channel?.invokeMethod("receiveTextFromSwiftUI", arguments: text)
    }

}

struct OntraceView: View {
    @State private var text: String = ""
    var onSubmit: (String) -> Void
    @Environment(\.presentationMode) var presentationMode 

    var body: some View {
        VStack(spacing: 20) {
            Text("Hello from SwiftUI")
                .font(.largeTitle)
            
            TextField("Enter Text", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                onSubmit(text)
                presentationMode.wrappedValue.dismiss()  
            }) {
                Text("Send Text to Flutter")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
