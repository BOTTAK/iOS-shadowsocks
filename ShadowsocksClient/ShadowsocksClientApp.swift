import SwiftUI
import SwiftData

@main
struct ShadowsocksClientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let dependencyFactory: DependencyFactory
    @State private var connection: Connection
    @State private var showServerConnectionView = false
    @State private var subscriptionChecked = false
    @State private var showActivityIndicator = true
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    init() {
        dependencyFactory = DependencyFactory.shared
        _connection = State(initialValue: Connection(shadowsocksManager: dependencyFactory.shadowsocksManager))
        UITraitCollection.current = UITraitCollection(userInterfaceStyle: .light)
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showActivityIndicator {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                checkSubscriptionStatus()
                            }
                        }
                } else if subscriptionChecked {
                    if !hasSeenOnboarding {
                        OnboardingView {
                            hasSeenOnboarding = true
                            showServerConnectionView = true
                        }
                    } else if SubscriptionManager.shared.activeSubscription || showServerConnectionView {
                        ServerConnectionView()
                            .environment(dependencyFactory)
                            .environment(connection)
                            .preferredColorScheme(.light)
                    } else {
//                        PayWallScreenWrapper {
//                            showServerConnectionView = true
//                        }
                        PayWallScreenView()
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
            await SubscriptionManager.shared.checkActiveSubscriptions()
            let isSubscribed = SubscriptionManager.shared.activeSubscription
            print("Subscription Status at App Start: \(isSubscribed ? "Active" : "Inactive")")
            DispatchQueue.main.async {
                self.subscriptionChecked = true
                self.showActivityIndicator = false
            }
        }
    }
}
