//
//  WallpaperCell.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import UIKit
import SnapKit

class WallpaperCell: UICollectionViewCell {
    
    lazy var wallpaperView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var wallpaper: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var photographerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    lazy var blur: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blur.layer.cornerRadius = 10
        blur.alpha = 0.5
        return blur
    }()
    
    class var identifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ vm: WallpaperModel) {
        photographerLabel.text = vm.photographer
        DispatchQueue.main.async {
            self.wallpaper.setImageWithKF(url: vm.url, size: self.wallpaper.bounds.size)
        }
    }
    
    func setupHierarchy() {
        addSubview(wallpaperView)
        wallpaperView.addSubview(wallpaper)
        wallpaperView.addSubview(photographerLabel)
        photographerLabel.addSubview(blur)
        
        wallpaperView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        wallpaper.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        photographerLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.12)
        }
    }
    
}
