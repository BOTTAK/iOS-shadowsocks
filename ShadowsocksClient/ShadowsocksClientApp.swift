import SwiftUI
import SwiftData

@main
struct ShadowsocksClientApp: App {
    private let dependencyFactory: DependencyFactory
    @State private var connection: Connection
    @State private var showServerConnectionView = false
    
    init() {
        dependencyFactory = DependencyFactory.shared
        _connection = State(initialValue: Connection(shadowsocksManager: dependencyFactory.shadowsocksManager))
        UITraitCollection.current = UITraitCollection(userInterfaceStyle: .light)
    }
    
    var body: some Scene {
        WindowGroup {
            if showServerConnectionView {
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
        .modelContainer(dependencyFactory.dataManager.sharedModelContainer)
#if os(macOS)
        .windowResizability(.contentSize)
        .windowToolbarStyle(.unifiedCompact)
#endif
    }
}
