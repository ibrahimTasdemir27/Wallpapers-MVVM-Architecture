//
//  UIColor+Ext.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 4.12.2022.
//

import UIKit.UIColor

extension UIColor {
    static let primaryColor = UIColor(displayP3Red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
    static let secondaryColor = UIColor(named: "secondaryColor")
    static let textColor = UIColor(named: "textColor")
    static let anotherColor = UIColor(displayP3Red: 243/255, green: 239/255, blue: 224/255, alpha: 1)
    
    convenience init(hexaString: String, alpha: CGFloat = 1) {
        let chars = Array(hexaString.dropFirst())
        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)}
    
    
}
