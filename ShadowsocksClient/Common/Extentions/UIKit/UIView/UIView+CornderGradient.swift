import UIKit

extension UIView {
    func gradientBorder(colors: [UIColor], isVertical: Bool){
        self.layer.masksToBounds = true
        
        //Create gradient layer
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero, size: self.bounds.size)
        gradient.colors = colors.map({ (color) -> CGColor in
            color.cgColor
        })

        //Set gradient direction
        if(isVertical){
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        }
        else {
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }

        //Create shape layer
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.path = UIBezierPath(roundedRect: gradient.frame.insetBy(dx: 1, dy: 1), cornerRadius: self.layer.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        //Add layer to view
        self.layer.addSublayer(gradient)
        gradient.zPosition = 0
    }
}
