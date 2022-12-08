//
//  String+Ext.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 5.12.2022.
//

import UIKit.NSAttributedString

extension String {
    
    func replace(_ count: Int) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        let range = NSRange(location: 0, length: count)
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold)], range: range)
        return attributedString
    }
}
