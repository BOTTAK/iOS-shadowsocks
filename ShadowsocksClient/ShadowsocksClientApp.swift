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
    @StateObject var interstitialAdsManager = InterstitialAdsManager()
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var showPayWallOneView = !UserDefaults.standard.bool(forKey: "hasSeenPayWallOneView")
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
                        }
                    } else if isFirstLaunch() { // Показываем PayWallOneView после OnboardingView на первом запуске
                        PayWallOneView()
                            .onAppear {
                                UserDefaults.standard.set(true, forKey: "hasSeenPayWallOneView") // Устанавливаем флаг, что экран был показан
                            }
                    } else if SubscriptionManager.shared.activeSubscription || showServerConnectionView {
                        ServerConnectionView()
                            .environment(dependencyFactory)
                            .environment(connection)
                            .preferredColorScheme(.light)
                    } else {
                        PayWallScreenView()
                            .edgesIgnoringSafeArea(.all)
                            .environment(dependencyFactory)
                            .environment(connection)
                            .environmentObject(interstitialAdsManager)
                            .onAppear {
                                interstitialAdsManager.loadInterstitialAd()
                            }
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
    
    func isFirstLaunch() -> Bool {
        let hasSeenPayWallOneView = UserDefaults.standard.bool(forKey: "hasSeenPayWallOneView")
        return !hasSeenPayWallOneView // Вернет true, если PayWallOneView еще не был показан
    }
}
