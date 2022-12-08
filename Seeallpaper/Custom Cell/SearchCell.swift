//
//  SearchCell.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 6.12.2022.
//

import UIKit

class SearchCell: UITableViewCell {
    
    lazy var searchLabel: PadLabel = {
        let label = PadLabel()
        backgroundColor = .primaryColor
        selectionStyle = .none
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "OpenSans-BoldItalic", size: 15)
        label.edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        return label
    }()
    
    class var identifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(searchLabel)
    
        searchLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame =  newValue
            frame.size.height -= 2
            super.frame = frame
        }
    }
    
}
