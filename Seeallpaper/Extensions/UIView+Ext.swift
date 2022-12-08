//
//  UIView+Ext.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 4.12.2022.
//

import UIKit

extension UIView {
    func drawShadow(offset: CGSize, opacity: Float = 0.25, color: UIColor = .systemGray6, radius: CGFloat = 22) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    func scrollAnimate() {
        self.center.x = self.center.x // Place it in the center x of the view.
        self.center.x += self.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
        // animate it from the left to the right
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut], animations: { [self] in
              self.center.x -= self.bounds.width
              self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func bounce() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(value: 0.7)
        animation.duration = 0.13
        animation.repeatCount = 1
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }
    
    func pulse(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 1.0
        pulse.toValue = 1.35
        pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.8
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulse")
    }
    
    func quickBounceCell() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 1)
        animation.toValue = NSNumber(value: 0.5)
        animation.duration = 0.16
        animation.repeatCount = 1
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }
    
    func animateCell(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 1)
        animation.toValue = NSNumber(value: 0.8)
        animation.duration = 0.14
        animation.repeatCount = 1
        animation.autoreverses = true
        layer.add(animation, forKey: nil)
    }
    
    func flash(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.22
        flash.fromValue = 1
        flash.toValue = 0.44
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
    
    func shake(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
}
