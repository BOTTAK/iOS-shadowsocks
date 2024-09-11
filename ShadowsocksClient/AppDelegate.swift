import UIKit
import AppMetricaCore


import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let configuration = AppMetricaConfiguration(apiKey: "9b4b9cb9-cbfd-4469-a89a-35814af5f906")
        AppMetrica.activate(with: configuration!)
        return true
    }
    
}
