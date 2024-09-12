import SwiftUI
import UIKit

struct PayWallScreenWrapper: UIViewControllerRepresentable {
    var onNavigateToNextScreen: () -> Void

    func makeUIViewController(context: Context) -> PayWallScreen {
        let viewController = PayWallScreen()
        viewController.onNavigateToNextScreen = onNavigateToNextScreen
        return viewController
    }

    func updateUIViewController(_ uiViewController: PayWallScreen, context: Context) {

    }
}
