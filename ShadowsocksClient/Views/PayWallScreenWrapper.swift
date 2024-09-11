import SwiftUI
import UIKit

struct PayWallScreenWrapper: UIViewControllerRepresentable {
    var onNavigateToNextScreen: () -> Void

    func makeUIViewController(context: Context) -> PayWallScreen {
        let viewController = PayWallScreen()
        viewController.onNavigateToNextScreen = onNavigateToNextScreen // Передаем замыкание в контроллер
        return viewController
    }

    func updateUIViewController(_ uiViewController: PayWallScreen, context: Context) {
        // Обновление состояния, если нужно
    }
}
