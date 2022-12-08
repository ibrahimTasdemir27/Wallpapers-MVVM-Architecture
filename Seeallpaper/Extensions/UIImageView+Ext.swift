//
//  UIImageView+Ext.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 4.12.2022.
//

import UIKit.UIImageView
import Kingfisher

extension UIImageView{
    func setImageWithKF(url: URL, size: CGSize) {
        
        let proccess =  DownsamplingImageProcessor(size: size)
        self.kf.setImage(with: url,
                         placeholder: .none,
                         options: [.processor(proccess), .scaleFactor(UIScreen.main.scale)], completionHandler: nil)
        }
    }
