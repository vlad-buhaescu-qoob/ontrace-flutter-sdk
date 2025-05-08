# ontrace_flutter_plugin

A Flutter plugin that enables Flutter developers to use native OntraceSDKs.

## Getting Started

This SDK captures and processes two images: a photo of a government-issued ID and a selfie. These are securely used to validate the user’s identity using Qoobiss’s identity verification system.

## Usage

API Key Required
To use this SDK, you must obtain an API_KEY from Qoobiss sales team. This key is required to authenticate your app with the identity validation service.

A full usage example is provided in the example/ directory. You can run it to see how to integrate and use the SDK in a real Flutter app.

```dart
await OntraceFlutterPlugin.instance.startIdentification(
    {"apiKey": "YOUR_API_KEY"},
    onMessage: (result) {
    log("Flutter side onMessage $result");
    },
    onComplete: (result) {
    log("Flutter side onComplete $result");
    },
);
```