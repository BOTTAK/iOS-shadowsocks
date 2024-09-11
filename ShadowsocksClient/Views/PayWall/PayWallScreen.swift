import UIKit
import Combine
import SafariServices
import StoreKit

enum PlanType {
    case monthly
    case annual
}

class PayWallScreen: UIViewController {
    //------------------------------------------------------------------------------
    // MARK: - Outlets
    //------------------------------------------------------------------------------
    @IBOutlet weak var closeButtonImg: UIImageView!
    @IBOutlet weak var mainTitleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var lottieImg: UIImageView!
    @IBOutlet weak var threeDaysView: UIView!
    @IBOutlet weak var threeDaysMainLbl: UILabel!
    @IBOutlet weak var threeDaysSubLbl: UILabel!
    @IBOutlet weak var treeDaysCheckImg: UIImageView!
    @IBOutlet weak var yearlyView: UIView!
    @IBOutlet weak var yearlyMainLbl: UILabel!
    @IBOutlet weak var yearlySubLbl: UILabel!
    @IBOutlet weak var yearlyChechImg: UIImageView!
    @IBOutlet weak var enableTrialView: UIView!
    @IBOutlet weak var enableTrialLbl: UILabel!
    @IBOutlet weak var enableTrialSwitch: UISwitch!
    @IBOutlet weak var sendButtonView: UIView!
    @IBOutlet weak var sendButtonLbl: UILabel!
    @IBOutlet weak var privacyLbl: UILabel!
    @IBOutlet weak var restoreLbl: UILabel!
    @IBOutlet weak var termsLbl: UILabel!
    
    //------------------------------------------------------------------------------
    // MARK: - Variables
    //------------------------------------------------------------------------------
    private var cancellables = Set<AnyCancellable>()
    var onNavigateToNextScreen: (() -> Void)?
    var selectedPlan: PlanType = .monthly
    var yearlyProduct: Product?
    var monthlyProduct: Product?
    //------------------------------------------------------------------------------
    // MARK: - View Life Cycle Methods
    //------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupUI()
        setupSwitchAction()
        setupLabelTapGestures()
        routToNextScreen()
        closePaywall()
        loadProducts()
    }
    
    //------------------------------------------------------------------------------
    // MARK: - Action Methods
    //------------------------------------------------------------------------------
    func routToNextScreen() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sendButtonViewTapped))
        sendButtonView.addGestureRecognizer(tapGesture)
        sendButtonView.isUserInteractionEnabled = true
    }
    
    @objc func sendButtonViewTapped(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.view?.alpha = 0.8
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                sender.view?.alpha = 1.0
            }
        }
        
        if selectedPlan == .annual {
            self.subscribeSuccessOneYear()
        } else {
            self.subscribeSuccessOneMonth()
        }
    }
    
    func closePaywall() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonImgTapped))
        closeButtonImg.addGestureRecognizer(tapGesture)
        closeButtonImg.isUserInteractionEnabled = true
    }
    
    //------------------------------------------------------------------------------
    // MARK: - Custom Methods
    //------------------------------------------------------------------------------
    func setupUI() {
        selectedPlan = .monthly
        view.backgroundColor = UIColor(hexString: "#F5F7FA")
        lottieView.backgroundColor = .clear
        closeButtonImg.image = UIImage(named: "Close_round_fill")
        lottieImg.image = UIImage(named: "social-app")
        mainTitleLbl.applyStyle(font: UIFont.appFont(size: 25, weight: .black), textColor: UIColor(hexString: "#0F1319"), textAligment: .center, numberOfLines: 0)
        mainTitleLbl.text = "Unlimited access"
        subTitleLbl.applyStyle(font: UIFont.appFont(size: 16, weight: .medium), textColor: UIColor(hexString: "#999999"), textAligment: .center, numberOfLines: 0)
        subTitleLbl.text = "Unlimited access to familiar\nservices, on your device 24/7"
        threeDaysView.backgroundColor = .white
        threeDaysView.layer.cornerRadius = 25
        threeDaysView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        threeDaysView.layer.shadowOpacity = 0.8
        threeDaysView.layer.shadowRadius = 2.0
        threeDaysView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        threeDaysMainLbl.applyStyle(font: UIFont.appFont(size: 16, weight: .bold), textColor: UIColor(hexString: "#141316"), textAligment: .left, numberOfLines: 0)
        threeDaysMainLbl.text = "3 day free trial"
        threeDaysSubLbl.applyStyle(font: UIFont.appFont(size: 13, weight: .medium), textColor: UIColor(hexString: "#999999"), textAligment: .left, numberOfLines: 0)
        threeDaysSubLbl.text = "$4.99 per month"
        treeDaysCheckImg.image = UIImage(named: "Check_ring_light")
        yearlyView.layer.cornerRadius = 25
        yearlyView.backgroundColor = .white
        yearlyMainLbl.applyStyle(font: UIFont.appFont(size: 16, weight: .bold), textColor: UIColor(hexString: "#141316"), textAligment: .left, numberOfLines: 0)
        yearlyMainLbl.text = "Yearly"
        yearlySubLbl.applyStyle(font: UIFont.appFont(size: 13, weight: .medium), textColor: UIColor(hexString: "#999999"), textAligment: .left, numberOfLines: 0)
        yearlySubLbl.text = "19.99 per year"
        yearlyChechImg.image = UIImage(named: "Check_ring_light")
        enableTrialView.backgroundColor = .white
        enableTrialView.layer.cornerRadius = 20
        enableTrialView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        enableTrialView.layer.shadowOpacity = 0.8
        enableTrialView.layer.shadowRadius = 1.0
        enableTrialView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        enableTrialLbl.applyStyle(font: UIFont.appFont(size: 16, weight: .bold), textColor: .black, textAligment: .left, numberOfLines: 0)
        enableTrialLbl.text = "Enable Free Trial"
        enableTrialSwitch.onTintColor = UIColor(hexString: "#F95825")
        sendButtonView.backgroundColor = UIColor(hexString: "#F95825")
        sendButtonView.layer.cornerRadius = 28
        sendButtonView.layer.shadowColor = UIColor(hexString: "#F95825").withAlphaComponent(0.67).cgColor
        sendButtonView.layer.shadowOpacity = 0.8
        sendButtonView.layer.shadowRadius = 20.0
        sendButtonView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        sendButtonLbl.applyStyle(font: UIFont.appFont(size: 18, weight: .bold), textColor: .white, textAligment: .center, numberOfLines: 0)
        sendButtonLbl.text = "Continue"
        privacyLbl.applyStyle(font: UIFont.appFont(size: 14, weight: .medium), textColor: UIColor(hexString: "#999999"), textAligment: .left, numberOfLines: 1)
        privacyLbl.text = "Privacy"
        restoreLbl.applyStyle(font: UIFont.appFont(size: 14, weight: .medium), textColor: UIColor(hexString: "#999999"), textAligment: .left, numberOfLines: 1)
        restoreLbl.text = "Restore"
        termsLbl.applyStyle(font: UIFont.appFont(size: 14, weight: .medium), textColor: UIColor(hexString: "#999999"), textAligment: .left, numberOfLines: 1)
        termsLbl.text = "Terms"
    }
    
    func loadProducts() {
        Task {
            await SubscriptionManager.shared.loadProducts()
            let products = SubscriptionManager.shared.products
            self.yearlyProduct = products.first { $0.id == "com.year.premium" }
            self.monthlyProduct = products.first { $0.id == "com.month.premium" }
            if let yearlyProduct = yearlyProduct {
                print("Годовой продукт загружен: \(yearlyProduct.displayName)")
            } else {
                print("Годовой продукт не найден")
            }
            
            if let monthlyProduct = monthlyProduct {
                print("Месячный продукт загружен: \(monthlyProduct.displayName)")
            } else {
                print("Месячный продукт не найден")
            }
        }
    }
    
    func setupSwitchAction() {
        enableTrialSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        updateViewSelection(isThreeDaysSelected: enableTrialSwitch.isOn)
    }
    
    @objc func switchValueChanged() {
        updateViewSelection(isThreeDaysSelected: enableTrialSwitch.isOn)
    }
    
    @objc func closeButtonImgTapped() {
        onNavigateToNextScreen?()
    }
    
    func updateViewSelection(isThreeDaysSelected: Bool) {
        if isThreeDaysSelected {
            selectedPlan = .monthly
            threeDaysView.layer.borderWidth = 2
            threeDaysView.layer.borderColor = UIColor(hexString: "F95825").cgColor
            treeDaysCheckImg.image = UIImage(named: "Check_fill")
            threeDaysView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
            threeDaysView.layer.shadowOpacity = 0.8
            threeDaysView.layer.shadowRadius = 2.0
            threeDaysView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            yearlyView.layer.borderWidth = 0
            yearlyView.layer.borderColor = UIColor.clear.cgColor
            yearlyChechImg.image = UIImage(named: "Check_ring_light")
            yearlyView.layer.shadowColor = UIColor.clear.cgColor
            yearlyView.layer.shadowOpacity = 0.0
            yearlyView.layer.shadowRadius = 0.0
            yearlyView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        } else {
            selectedPlan = .annual
            yearlyView.layer.borderWidth = 2
            yearlyView.layer.borderColor = UIColor(hexString: "#F95825").cgColor
            yearlyChechImg.image = UIImage(named: "Check_fill")
            yearlyView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
            yearlyView.layer.shadowOpacity = 0.8
            yearlyView.layer.shadowRadius = 2.0
            yearlyView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            threeDaysView.layer.borderWidth = 0
            threeDaysView.layer.borderColor = UIColor.clear.cgColor
            treeDaysCheckImg.image = UIImage(named: "Check_ring_light")
            threeDaysView.layer.shadowColor = UIColor.clear.cgColor
            threeDaysView.layer.shadowOpacity = 0.0
            threeDaysView.layer.shadowRadius = 0.0
            threeDaysView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        }
    }
    
    func subscribeSuccessOneYear() {
        guard let yearlyProduct = yearlyProduct else {
            print("Годовой продукт не найден")
            return
        }
        
        Task {
            await SubscriptionManager.shared.purchaseProduct(yearlyProduct)
            print("После покупки: подписка активна — \(SubscriptionManager.shared.activeSubscription)")
            
            if SubscriptionManager.shared.activeSubscription {
                onNavigateToNextScreen?()
            } else {
                print("Подписка не была активирована.")
            }
        }
    }
    
    func subscribeSuccessOneMonth() {
        print("Перед покупкой: подписка активна — \(SubscriptionManager.shared.activeSubscription)")
        guard let monthlyProduct = monthlyProduct else {
            print("Месячный продукт не найден")
            return
        }

        Task {
            await SubscriptionManager.shared.purchaseProduct(monthlyProduct)
            print("После покупки: подписка активна — \(SubscriptionManager.shared.activeSubscription)")
            
            if SubscriptionManager.shared.activeSubscription {
                onNavigateToNextScreen?()
            } else {
                print("Подписка не была активирована.")
            }
        }
    }
    
    func setupLabelTapGestures() {
        let privacyTapGesture = UITapGestureRecognizer(target: self, action: #selector(privacyLblTapped))
        privacyLbl.isUserInteractionEnabled = true
        privacyLbl.addGestureRecognizer(privacyTapGesture)
        
        let termsTapGesture = UITapGestureRecognizer(target: self, action: #selector(termsLblTapped))
        termsLbl.isUserInteractionEnabled = true
        termsLbl.addGestureRecognizer(termsTapGesture)
        
        let restoreTapGesture = UITapGestureRecognizer(target: self, action: #selector(restoreLblTapped))
        restoreLbl.isUserInteractionEnabled = true
        restoreLbl.addGestureRecognizer(restoreTapGesture)
    }
    
    @objc func privacyLblTapped() {
        openURL("https://yourprivacyurl.com")
    }
    
    @objc func termsLblTapped() {
        openURL("https://yourtermsurl.com")
    }
    
    @objc func restoreLblTapped() {
        Task {
            await SubscriptionManager.shared.restorePurchases()
            if SubscriptionManager.shared.activeSubscription {
                onNavigateToNextScreen?()
                print("Подписка успешно восстановлена!")
            } else {
                print("Подписка не была восстановлена.")
            }
        }
    }
    
    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
}
