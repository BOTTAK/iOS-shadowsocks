import UIKit

extension UITextField {

   func setPadding(left: CGFloat? = nil, right: CGFloat? = nil){
       if let left = left {
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
          self.leftView = paddingView
          self.leftViewMode = .always
       }

       if let right = right {
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
           self.rightView = paddingView
           self.rightViewMode = .always
       }
   }
    
    func applyTextFieldStyle(cornerRadius: CGFloat = 0,
                             borderWidth: CGFloat = 0,
                             borderColor: UIColor? = nil,
                             font: UIFont? = nil,
                             textColor: UIColor? = nil,
                             placeholder: String? = nil) {
                  
                  self.layer.cornerRadius = cornerRadius
                  self.layer.borderWidth = borderWidth
                  
                  if let borderColor = borderColor {
                      self.layer.borderColor = borderColor.cgColor
                  }
                  
                  if let font = font {
                      self.font = font
                  }
                  
                  if let textColor = textColor {
                      self.textColor = textColor
                  }
                  
                  if let placeholder = placeholder {
                      self.placeholder = placeholder
                  }
              }

}
