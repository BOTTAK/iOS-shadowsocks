import GoogleMobileAds

class InterstitialAdsManager: NSObject, GADFullScreenContentDelegate, ObservableObject {

    @Published var interstitialAdLoaded: Bool = false
    var interstitialAd: GADInterstitialAd?
    
    override init() {
        super.init()
    }
    
    func loadInterstitialAd() {
            print("ℹ️ Starting interstitial ad load...")
            
            // Проверка, указан ли GADApplicationIdentifier в Info.plist
            if Bundle.main.object(forInfoDictionaryKey: "GADApplicationIdentifier") == nil {
                print("🛑 GADApplicationIdentifier is missing from Info.plist.")
                return
            }

            let adUnitID = "ca-app-pub-5664210517653277/1265868912"
            
            // Проверка Ad Unit ID перед загрузкой
            if adUnitID.isEmpty {
                print("🛑 Ad Unit ID is empty or invalid.")
                return
            } else {
                print("ℹ️ Ad request created with unit ID: \(adUnitID)")
            }

            let request = GADRequest()

            GADInterstitialAd.load(withAdUnitID: adUnitID, request: request) { [weak self] ad, error in
                guard let self = self else {
                    print("🛑 Self is nil, unable to continue.")
                    return
                }

                if let error = error {
                    print("🔴 Error loading interstitial ad: \(error.localizedDescription)")
                    self.interstitialAdLoaded = false
                    return
                }

                if let ad = ad {
                    print("✅ Interstitial ad loaded successfully.")
                    self.interstitialAd = ad
                    self.interstitialAd?.fullScreenContentDelegate = self
                    self.interstitialAdLoaded = true
                    print("ℹ️ Ad delegate set and ad marked as ready.")
                } else {
                    print("🟡 Interstitial ad returned as nil.")
                }
            }
        }
    
    func displayInterstitialAd() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let root = windowScene?.windows.first?.rootViewController else {
            return
        }
        if let add = interstitialAd {
            add.present(fromRootViewController: root)
            self.interstitialAdLoaded = false
        } else {
            print("🔵 No interstitial ad to display.")
        }
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("🤯 Error presenting interstitial ad: \(error.localizedDescription)")
        self.loadInterstitialAd()
    }
    
    func adWillPresentFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        print("🤩 Interstitial ad will present.")
    }
    
    func adDidDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        print("😩 Interstitial ad did dismiss.")
    }
}
