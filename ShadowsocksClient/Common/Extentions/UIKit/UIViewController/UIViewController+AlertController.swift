import UIKit

extension UIViewController {
    
    /// Alert with one action button
    ///
    /// - Parameters:
    ///   - title: title for alert
    ///   - message: bogy for alert
    ///   - buttonTitle: alert button title
    ///   - buttonAction: alert button action
    func showAlertWithOneButton(
        title: String,
        message: String? = nil,
        buttonTitle: String,
        buttonStyle: UIAlertAction.Style = .default,
        buttonAction: (() -> Void)? = nil
    ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: buttonTitle, style: buttonStyle) { (_) in
            buttonAction?()
        }
        alertController.addAction(alertButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Alert with two action buttons
    ///
    /// - Parameters:
    ///   - title: title for alert
    ///   - firstButtonTitle: first button title
    ///   - secondButtonTitle: second button title
    ///   - firstButtonAction: first button action
    ///   - secondButtonAction: second button action
    func showAlertWithTwoButtons(
        title: String?,
        message: String? = nil,
        firstButtonTitle: String,
        secondButtonTitle: String,
        firstButtonAction: (() -> Void)?,
        secondButtonAction: (() -> Void)?) {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let firstAlertButton = UIAlertAction(title: firstButtonTitle, style: .default) { (_) in
                firstButtonAction?()
            }
            let secondAlertButton = UIAlertAction(title: secondButtonTitle, style: .default) { (_) in
                secondButtonAction?()
            }
            
            alertController.addAction(firstAlertButton)
            alertController.addAction(secondAlertButton)
            
            self.present(alertController, animated: true, completion: nil)
        }
    
    
    /// Show alert with cancel button and custom action button
    /// - Parameters:
    ///   - title: Title for alert
    ///   - buttonTitle: Title for action button
    ///   - buttonAction: Action for action button
    func showAlertWithCancel(
        title: String,
        buttonTitle: String,
        buttonStyle: UIAlertAction.Style = .default,
        buttonAction: (() -> Void)?
    ) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let actionButton = UIAlertAction(title: buttonTitle, style: buttonStyle) { (_) in
            if let buttonAction = buttonAction {
                buttonAction()
            }
        }
        
        // Не забыть поменять название кнопки на актуальную
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(actionButton)
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
