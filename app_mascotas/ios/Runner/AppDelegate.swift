import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSSErvices.provideAPIKey("AIzaSyCW7oQvJj05PXKlLMoZ_3QJHiFSfavbC4c")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
