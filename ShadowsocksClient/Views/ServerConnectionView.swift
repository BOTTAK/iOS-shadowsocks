import SwiftUI
import SwiftData

struct ServerConnectionView: View {
    @Environment(Connection.self) private var connection
    @State private var isShowingAlert = false
    @State private var isTestingMode = false
    @State private var hardcodedServer: Server? = Server(
        title: "Hardcoded Server",
        country: .russia,
        config: Config(
            host: "77.221.135.64",
            port: "48128",
            method: .chacha20IetfPoly1305,
            password: "BsH1jedrzqXmToHCkdG7UH"
        )
    )
    @State private var showPayWall = false
    
    private var isConnectButtonDisabled: Bool {
        return connection.status == .connected || connection.status == .connecting
    }

    private var isDisconnectButtonDisabled: Bool {
        return connection.status == .disconnected || connection.status == .disconnecting
    }

    var body: some View {
        VStack(spacing: .zero) {
            Spacer()

            VStack(spacing: 16) {
                TimerView(connectedDate: connection.connectedDate)
                StatusView(status: connection.status)
            }

            Spacer()
            
            ToggleButton(isAnimating: !isDisconnectButtonDisabled) {
                Task {
                    if !isTestingMode {
                        let subscriptionStatus = await SubscriptionManager.shared.activeSubscription
                        print("Subscription Status: \(subscriptionStatus ? "Active" : "Inactive")")
                        if !subscriptionStatus {
                            showPayWall = true
                        } else {
                            toggleConnection()
                        }
                    } else {
                        toggleConnection()
                    }
                }
            }
            .disabled(isConnectButtonDisabled && isDisconnectButtonDisabled)

            Spacer()
        }
        .ignoresSafeArea()
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Error"),
                message: Text(connection.errorMessage?.key ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
        .onChange(of: connection.errorMessage, initial: false) {
            if connection.errorMessage != nil {
                isShowingAlert = true
            }
        }
        .fullScreenCover(isPresented: $showPayWall) {
            PayWallScreenWrapper {
                    showPayWall = false
                    
                }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func toggleConnection() {
        if isDisconnectButtonDisabled {
            connection.toggle(defaultServer: hardcodedServer!)
            print("Connecting...")
        } else {
            connection.toggle(defaultServer: hardcodedServer!)
            print("Disconnecting...")
        }
    }
}

#Preview {
    ServerConnectionView()
        .environment(Connection(shadowsocksManager: DependencyFactory.shared.shadowsocksManager))
#if os(macOS)
        .frame(width: 400, height: 480)
#endif
}
