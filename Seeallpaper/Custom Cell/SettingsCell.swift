//
//  SettingsCell.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 7.12.2022.
//

import UIKit

enum SwitchMode {
    
}

class SettingsCell: UITableViewCell {
    
    lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var switchMode: UISwitch = {
        let switchMode = UISwitch()
        backgroundColor = .systemGray6
        contentView.isUserInteractionEnabled = true
        switchMode.setOn(false, animated: true)
        switchMode.isEnabled = true
        switchMode.isHidden = true
        switchMode.thumbTintColor = .darkGray
        switchMode.onTintColor = .clear
        switchMode.addTarget(self, action: #selector(changeMode(_ :)), for: .touchUpInside)
        return switchMode
    }()
    
    class var identifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(settingsLabel)
        addSubview(switchMode)
        
        settingsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview()
        }
        switchMode.snp.makeConstraints { make in
            make.centerY.equalTo(settingsLabel.snp.centerY)
            make.left.equalTo(settingsLabel.snp.right)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    @objc private func changeMode(_ sender: UISwitch) {
        if sender.isOn {
            sender.thumbTintColor = .white
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            sender.thumbTintColor = .darkGray
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
      
    }
}

