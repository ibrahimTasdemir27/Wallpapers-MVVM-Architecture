//
//  UITextField+Ext.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 6.12.2022.
//

import UIKit.UITextField

extension UITextField{
    
    func staticPadding(leftPadding : Int = 0 , rightPadding : Int = 0) {
        guard self.text != nil else {
            return
        }
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: Int(self.frame.size.height)))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: Int(self.frame.size.height)))
        self.rightViewMode = .always
    }
}
