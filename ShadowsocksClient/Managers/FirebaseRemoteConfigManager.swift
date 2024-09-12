import Foundation
import FirebaseRemoteConfig
//import FirebaseRemoteConfigInternal

class FirebaseRemoteConfigManager: ObservableObject {
    @Published var server: Server? = nil
    private var remoteConfig: RemoteConfig
    
    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func fetchRemoteConfigData() {
        remoteConfig.fetch { [weak self] status, error in
            if status == .success {
                print("Config fetched!")
                self?.remoteConfig.activate { _, _ in
                    self?.printAllConfigValues()
                    
                    let host = self?.remoteConfig.configValue(forKey: "server_host").stringValue ?? "77.221.135.64"
                    let port = self?.remoteConfig.configValue(forKey: "server_port").stringValue ?? "48128"
                    let password = self?.remoteConfig.configValue(forKey: "server_password").stringValue ?? "BsH1jedrzqXmToHCkdG7UH"
                    self?.server = Server(
                        title: "Remote Config Server",
                        country: .russia,
                        config: Config(
                            host: host,
                            port: port,
                            method: .chacha20IetfPoly1305,
                            password: password
                        )
                    )
                    
                    print("Remote Config Server: \(self?.server!)")
                }
            } else {
                print("Config fetch failed: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
    
    private func printAllConfigValues() {
        let allKeys = remoteConfig.allKeys(from: .remote)
        for key in allKeys {
            let value = remoteConfig.configValue(forKey: key).stringValue ?? "N/A"
            print("\(key): \(value)")
        }
    }
}
