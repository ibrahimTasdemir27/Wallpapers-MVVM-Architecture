//
//  PopupController.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 5.12.2022.
//

import UIKit


class ContentViewController: UIViewController {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    lazy var photographerProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.purple.cgColor
        imageView.layer.masksToBounds = true
        DispatchQueue.main.async {
            imageView.layer.cornerRadius = imageView.frame.width / 2
        }
        imageView.backgroundColor = wallpaperVM.color
        return imageView
    }()
    
    lazy var photographerUsername: UILabel = {
        let label = UILabel()
        label.text = wallpaperVM.userName
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var parentContentView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    lazy var wallpaper: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        DispatchQueue.main.async { [self] in
            imageView.setImageWithKF(url: wallpaperVM.urlLarge, size: imageView.bounds.size)
        }
        return imageView
    }()
    
    lazy var photographerLabel: UILabel = {
        let label = UILabel()
        label.text = wallpaperVM.photographer
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var blur: UIVisualEffectView = {
        let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        visualEffect.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        visualEffect.layer.masksToBounds = true
        visualEffect.alpha = 0.5
        return visualEffect
    }()
    
    lazy var paddingView: UIVisualEffectView = {
        let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        visualEffect.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        visualEffect.layer.masksToBounds = true
        visualEffect.alpha = 0.5
        return visualEffect
    }()

    var wallpaperVM: WallpaperModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupHirearchy()
    }
    
    func setupUI() {
        view.backgroundColor = .clear
        navigationItem.title = TitleController.showPaper.rawValue
    }
    
    func setupHirearchy() {
        view.addSubview(contentView)
        contentView.addSubview(photographerProfile)
        contentView.addSubview(photographerUsername)
        contentView.addSubview(parentContentView)
        parentContentView.addSubview(wallpaper)
        wallpaper.addSubview(paddingView)
        wallpaper.addSubview(photographerLabel)
        photographerLabel.addSubview(blur)
        
        
        contentView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.58)
            make.width.equalToSuperview().multipliedBy(0.97)
        }
        photographerProfile.snp.makeConstraints { make in
            make.bottom.equalTo(parentContentView.snp.top).offset(10)
            make.left.equalTo(parentContentView.snp.left).offset(12)
            make.width.height.equalTo(50)
        }
        photographerUsername.snp.makeConstraints { make in
            make.bottom.equalTo(parentContentView.snp.top).offset(10)
            make.left.equalTo(photographerProfile.snp.right).offset(5)
            make.right.equalTo(parentContentView.snp.right).offset(-20)
            make.height.equalTo(photographerProfile.snp.height)
        }
        parentContentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(25)
            make.height.equalToSuperview().multipliedBy(0.9)
            make.width.equalToSuperview()
        }
        wallpaper.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        paddingView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(30)
        }
        photographerLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalTo(paddingView.snp.left)
            make.left.equalToSuperview()
            make.height.equalTo(paddingView.snp.height)
        }
    }
}
