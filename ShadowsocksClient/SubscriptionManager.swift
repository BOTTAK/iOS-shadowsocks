import StoreKit

@MainActor
class SubscriptionManager: ObservableObject {
    
    static let shared = SubscriptionManager()
    
    @Published var products: [Product] = []
    @Published var activeSubscription: Bool = false
    
    private let productIDs: [String] = ["com.year.premium", "com.month.premium"]
    private var updatesTask: Task<Void, Never>?
    
    private init() {
        self.updatesTask = observeTransactionUpdates()
        
        Task {
            await checkActiveSubscriptions()
        }
    }
    
    deinit {
        updatesTask?.cancel()
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        return Task(priority: .background) { [weak self] in
            for await verificationResult in Transaction.updates {
                await self?.handleTransaction(verificationResult)
            }
        }
    }
    
    private func handleTransaction(_ verificationResult: VerificationResult<Transaction>) async {
        switch verificationResult {
        case .verified(let transaction):
            await transaction.finish()
            print("Транзакция завершена и проверена: \(transaction.productID)")
            await checkActiveSubscriptions()
        case .unverified(_, let error):
            print("Ошибка проверки транзакции: \(error)")
        }
    }
    
    func loadProducts() async {
        do {
            self.products = try await Product.products(for: productIDs)
            print("Продукты загружены: \(self.products)")
        } catch {
            print("Не удалось загрузить продукты: \(error)")
        }
    }
    
    func purchaseProduct(_ product: Product) async {
        do {
            let result = try await product.purchase()

            switch result {
            case let .success(.verified(transaction)):
                await transaction.finish()
                print("Успешная покупка: \(product.id)")
                await checkActiveSubscriptions()

            case let .success(.unverified(_, error)):
                print("Покупка не подтверждена: \(error)")
            case .pending:
                print("Ожидание подтверждения покупки.")
            case .userCancelled:
                print("Пользователь отменил покупку.")
            @unknown default:
                print("Неизвестный результат покупки.")
            }
        } catch {
            print("Ошибка при покупке: \(error)")
        }
    }
    
    func restorePurchases() async {
        do {
            try await AppStore.sync()
            await checkActiveSubscriptions()
            print("Покупки восстановлены.")
        } catch {
            print("Ошибка при восстановлении покупок: \(error)")
        }
    }
    
    func checkActiveSubscriptions() async {
        var hasSubscription = false
        for await verificationResult in Transaction.currentEntitlements {
            switch verificationResult {
            case .verified(let transaction):
                if transaction.productType == .autoRenewable {
                    hasSubscription = true
                    break
                }
            case .unverified(_, let error):
                print("Ошибка проверки подписки: \(error)")
            }
        }
        self.activeSubscription = hasSubscription
    }
}
