import SwiftUI
import StoreKit

struct PayWallScreenView: View {
    @State private var showServerConnectionView = false
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedOption: SubscriptionType? = .weekly
    @State private var yearlyProduct: Product? = nil
    @State private var monthlyProduct: Product? = nil
    @State private var isSubscribed = false
    var onNavigateToNextScreen: (() -> Void)?
    let subscriptionOptions: [SubscriptionOption] = [
        SubscriptionOption(
            type: .weekly,
            title: "Weekly",
            subtitle: "First 3 days free • Then $6.99 /Week",
            showBadge: false,
            buttonText: "Try free for 3 days"
        ),
        SubscriptionOption(
            type: .annual,
            title: "Annual",
            subtitle: "First 14 days free • Then $59.99 /Year",
            showBadge: true,
            buttonText: "Try free for 14 days"
        ),
        SubscriptionOption(
            type: .monthly,
            title: "Monthly",
            subtitle: "First 7 days free • Then $9.99 /Month",
            showBadge: false,
            buttonText: "Try free for 7 days"
        )
    ]
    @StateObject var interstitialAdsManager = InterstitialAdsManager()
    var body: some View {
        VStack {
            HStack {
                
                Button(action: {
                    showIntersistitial()
                }) {
                    Image("Close_round_fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                }
                .padding(.top, 60)
                .padding(.leading, 20)
                Spacer()
            }
            Spacer()
                .frame(height: 100)
            Image("belarus")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Spacer()
                .frame(height: 20)
            Text("Get Premium to connect to Belarus")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 10)
            Text("Premium includes over 3,200 servers in 80+\ncountries and 20+ cities")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 10)
            
            VStack(spacing: 10) {
                ForEach(subscriptionOptions) { option in
                    FeatureView(
                        title: option.title,
                        subtitle: option.subtitle,
                        showBadge: option.showBadge,
                        isSelected: selectedOption == option.type,
                        action: {
                            selectedOption = option.type
                        }
                    )
                    .padding(.vertical, 5)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
            
            Spacer()
                .frame(height: 30)
            Button(action: {
                // Логика подписки
                subscribe()
            }) {
                Text(subscriptionOptions.first(where: { $0.type == selectedOption })?.buttonText ?? "Subscribe")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color.accent)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    // Логика открытия Privacy Policy
                    openURL("https://docs.google.com/document/d/19V7SlzGIwBu2pybvLPceYVdi8G5QsHy9ZTDHP_gZOpc/edit?usp=sharing")
                }) {
                    Text("Privacy")
                        .font(.system(size: 14))
                        .foregroundColor(Color.accent)
                }

                Button(action: {
                    // Логика восстановления покупки
                    restorePurchases()
                }) {
                    Text("Restore purchase")
                        .font(.system(size: 14))
                        .foregroundColor(Color.accent)
                }

                Button(action: {
                    // Логика открытия Terms of Use
                    openURL("https://docs.google.com/document/d/19V7SlzGIwBu2pybvLPceYVdi8G5QsHy9ZTDHP_gZOpc/edit?usp=sharing")
                }) {
                    Text("Terms of Use")
                        .font(.system(size: 14))
                        .foregroundColor(Color.accent)
                }
            }
            .padding(.bottom, 30)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
        }
        .onAppear {
            loadProducts() // Загружаем продукты при появлении

        }
        .fullScreenCover(isPresented: $showServerConnectionView) {
            ServerConnectionView() // Переход в полноэкранном режиме
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
    
    // Загружаем подписочные продукты
    func loadProducts() {
        Task {
            await SubscriptionManager.shared.loadProducts()
            let products = SubscriptionManager.shared.products
            self.yearlyProduct = products.first { $0.id == "com.year.premium" }
            self.monthlyProduct = products.first { $0.id == "com.month.premium" }
        }
    }
    
    // Логика подписки
    func subscribe() {
        if selectedOption == .annual {
            subscribeSuccessOneYear()
        } else if selectedOption == .monthly {
            subscribeSuccessOneMonth()
        }
    }
    
    // Подписка на год
    func subscribeSuccessOneYear() {
        guard let yearlyProduct = yearlyProduct else {
            print("Годовой продукт не найден")
            return
        }

        Task {
            await SubscriptionManager.shared.purchaseProduct(yearlyProduct)
            if SubscriptionManager.shared.activeSubscription {
                showServerConnectionView = true
            } else {
                print("Подписка не была активирована.")
            }
        }
    }

    // Подписка на месяц
    func subscribeSuccessOneMonth() {
        guard let monthlyProduct = monthlyProduct else {
            print("Месячный продукт не найден")
            return
        }

        Task {
            await SubscriptionManager.shared.purchaseProduct(monthlyProduct)
            if SubscriptionManager.shared.activeSubscription {
                showServerConnectionView = true
            } else {
                print("Подписка не была активирована.")
            }
        }
    }
    
    // Восстановление покупок
    func restorePurchases() {
        Task {
            await SubscriptionManager.shared.restorePurchases()
            isSubscribed = SubscriptionManager.shared.activeSubscription
        }
    }
    
    // Открываем URL
    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func showIntersistitial() {
        interstitialAdsManager.displayInterstitialAd()
    }
}

struct PayWallScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallScreenView()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
