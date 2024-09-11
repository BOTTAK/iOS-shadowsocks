import SwiftUI
import SwiftData

@main
struct ShadowsocksClientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let dependencyFactory: DependencyFactory
    @State private var connection: Connection
    @State private var showServerConnectionView = false
    @State private var activeSubscription = false
    @State private var subscriptionChecked = false
    @State private var showActivityIndicator = true
    
    init() {
        dependencyFactory = DependencyFactory.shared
        _connection = State(initialValue: Connection(shadowsocksManager: dependencyFactory.shadowsocksManager))
        UITraitCollection.current = UITraitCollection(userInterfaceStyle: .light)
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showActivityIndicator {
                    ProgressView("Checking subscription...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                checkSubscriptionStatus()
                            }
                        }
                } else if subscriptionChecked {
                    if activeSubscription || showServerConnectionView {
                        ServerConnectionView()
                            .environment(dependencyFactory)
                            .environment(connection)
                            .preferredColorScheme(.light)
                    } else {
                        PayWallScreenWrapper {
                            showServerConnectionView = true
                        }
                        .edgesIgnoringSafeArea(.all)
                        .environment(dependencyFactory)
                        .environment(connection)
                    }
                }
            }
        }
        .modelContainer(dependencyFactory.dataManager.sharedModelContainer)
    }
    
    private func checkSubscriptionStatus() {
        Task {
            let isSubscribed = await SubscriptionManager.shared.activeSubscription
            print("Subscription Status at App Start: \(isSubscribed ? "Active" : "Inactive")")
            DispatchQueue.main.async {
                self.activeSubscription = isSubscribed
                self.subscriptionChecked = true
                self.showActivityIndicator = false
            }
        }
    }
}
