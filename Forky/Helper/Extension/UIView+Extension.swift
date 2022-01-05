//
//  UIView+Extension.swift
//  Forky
//
//  Created by Vivek Sadariya on 04/10/21.
//

import UIKit

extension UIView {
    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }

    func toImage() -> UIImage {
       let renderer = UIGraphicsImageRenderer(bounds: bounds)
       return renderer.image { rendererContext in
           layer.render(in: rendererContext.cgContext)
       }
    }
    
    func rotate() {
       let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
       rotation.toValue = NSNumber(value: Double.pi)
        rotation.duration = 1
       rotation.isCumulative = true
       rotation.repeatCount = 0
       self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func applyVerticalGradient(colours: [UIColor]) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = colours.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func addShadow(cornerRadius:CGFloat = 10.0,opacity:Float = 0.25) {
        // Shadow
        layer.shadowColor = UIColor.black?.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        layer.cornerRadius = cornerRadius;
    }
    
    func addShadowToTopOnly(cornerRadius:CGFloat = 10.0,opacity:Float = 0.05) {
        // Shadow
        layer.shadowColor = UIColor.black?.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: -7.5)
        layer.shadowRadius = 5.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
//        layer.cornerRadius = cornerRadius;
    }
    
    func addShadowWithAlpha(opacity:Float = 0.5) {
        // Shadow
        layer.shadowColor = UIColor.black?.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        //layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addShadowWithNewDesign(opacity:Float = 0.2) {
        // Shadow
        layer.shadowColor = UIColor.black?.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3.0
        //layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addShadowWithOffset(opacity:Float = 0.5, shadowRadius:Float = 3.0, x:CGFloat = 0.0, y:CGFloat = 1.5) {
        // Shadow
        layer.shadowColor = UIColor.black?.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = 3.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func startShimmeringEffect() {
        let light = UIColor.red.cgColor
        let alpha = UIColor(red: 206/255, green: 10/255, blue: 10/255, alpha: 0.1).cgColor
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.colors = [light, alpha, light]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.525)
        gradient.locations = [0.35, 0.50, 0.65]
        self.layer.mask = gradient
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9,1.0]
        animation.duration = 0.7
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
    func stopShimmeringEffect() {
        self.layer.mask = nil
    }
    
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(self)
    }
    
    class func instantiateFromNib<T: UIView>(_ viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }
    
    func roundedView() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
    
}
