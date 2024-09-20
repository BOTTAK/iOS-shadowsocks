import SwiftUI
import StoreKit

enum SubscriptionType {
    case weekly
    case annual
    case monthly
}

struct Page {
    let image: String
    let text: String
}

struct SubscriptionOption: Identifiable {
    let id = UUID()
    let type: SubscriptionType
    let title: String
    let subtitle: String
    let showBadge: Bool
    let buttonText: String
}

struct PayWallOneView: View {
    let pages: [Page] = [
        Page(image: "paywall1", text: "Surf the web securely"),
        Page(image: "paywall2", text: "Protect your data"),
        Page(image: "paywall1", text: "Enjoy private browsing"),
        Page(image: "paywall2", text: "Stay anonymous online"),
        Page(image: "paywall1", text: "Secure your connection")
    ]
    
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
    
    @State private var currentPage = 0
    @State private var selectedOption: SubscriptionType? = .weekly
    @State private var yearlyProduct: Product? = nil
    @State private var monthlyProduct: Product? = nil
    @State private var showServerConnectionView = false
    @State private var isSubscribed = false

    var body: some View {
        VStack(spacing: 0) {
            Image(pages[currentPage].image)
                .resizable()
                .scaledToFill()
                .frame(height: 320)
                .frame(maxWidth: .infinity)
                .clipped()
                .ignoresSafeArea(edges: .top)
            
            Spacer().frame(height: 20)
            
            Text(pages[currentPage].text)
                .font(.system(size: 22))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer().frame(height: 20)
            
            if currentPage < 4 {
                // Показать индикаторы, если currentPage < 4
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.accent : Color.gray)
                            .frame(width: 10, height: 10)
                            .onTapGesture {
                                currentPage = index
                            }
                    }
                }
            } else {
                Button(action: {
                    // Действие кнопки подписки
                }) {
                    Text("Proceed with Ads")
                        .foregroundColor(Color.accent)
                        .font(.system(size: 16).weight(.bold))
                        .frame(maxWidth: .infinity)
                }
            }
            
            Spacer().frame(height: 30)
            
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
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
            }
            
            Spacer().frame(height: 30)
            
            Button(action: {
                // Действие кнопки подписки
            }) {
                Text(subscriptionOptions.first(where: { $0.type == selectedOption })?.buttonText ?? "Subscribe")
                    .foregroundColor(.white)
                    .font(.system(size: 16).weight(.bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.accent)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 20)
            
            Spacer().frame(height: 20)
            
            HStack(spacing: 20) {
                ForEach(["Terms of Use", "Restore purchase", "Privacy Policy"], id: \.self) { title in
                    Button(action: {
                        // Действие кнопки
                    }) {
                        Text(title)
                            .font(.system(size: 14))
                            .foregroundColor(Color.accent)
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            
            Spacer()
        }
        .onAppear {
            loadProducts() // Загружаем продукты при появлении
        }
        .fullScreenCover(isPresented: $showServerConnectionView) {
            ServerConnectionView() // Переход в полноэкранном режиме
        }
        .ignoresSafeArea(edges: .top)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        // Свайп влево
                        if currentPage < pages.count - 1 {
                            currentPage += 1
                        }
                    } else if value.translation.width > 50 && currentPage > 0 {
                        // Свайп вправо
                        currentPage -= 1
                    }
                }
        )
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
}

struct FeatureView: View {
    var title: String
    var subtitle: String
    var showBadge: Bool = false
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isSelected ? Color.accent : Color.clear, lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 18).weight(.semibold))
                    .foregroundColor(.black.opacity(0.5))
                
                Text(subtitle)
                    .font(.system(size: 14)).fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.top, 15)
            .padding(.leading, 18)
            .padding(.trailing, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if showBadge {
                Text("Best value")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .frame(width: 70, height: 25)
                    .background(Color.accent)
                    .cornerRadius(30)
                    .padding(.top, 7)
                    .padding(.trailing, 7)
            }
        }
        .frame(height: 75)
        .onTapGesture {
            action()
        }
    }
}

struct PayWallOneView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallOneView()
    }
}
