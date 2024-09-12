import SwiftUI

struct ServerConnectionView: View {
    @Environment(Connection.self) private var connection
    @StateObject private var firebaseRemoteConfigManager = FirebaseRemoteConfigManager()
    @State private var isShowingAlert = false
    @State private var isTestingMode = false
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
        .onAppear {
            firebaseRemoteConfigManager.fetchRemoteConfigData()
        }
        .onChange(of: connection.errorMessage, initial: false) {
            if connection.errorMessage != nil {
                isShowingAlert = true
            }
        }
        
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Error"),
                message: Text(connection.errorMessage?.key ?? ""),
                dismissButton: .default(Text("OK"))
            )
        }
        .fullScreenCover(isPresented: $showPayWall) {
            PayWallScreenWrapper {
                showPayWall = false
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func toggleConnection() {
        if let server = firebaseRemoteConfigManager.server {
            if isDisconnectButtonDisabled {
                connection.toggle(defaultServer: server)
                print("Connecting...")
            } else {
                connection.toggle(defaultServer: server)
                print("Disconnecting...")
            }
        } else {
            print("Server is not ready yet.")
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
