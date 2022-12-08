//
//  SearchViewController.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 6.12.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    lazy var icon: UILabel = {
        let label = UILabel()
        label.text = "WP"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 28)
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 3.2
        label.layer.masksToBounds = true
        DispatchQueue.main.async {
            label.layer.cornerRadius = label.bounds.width / 2
        }
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 19.2)
        label.text = "Wallpapers"
        return label
    }()
    
    lazy var search: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "magnifyingglass")
        return imageView
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.placeholder = "Search"
        textField.tintColor = .gray
        textField.delegate = self
        textField.textColor = .primaryColor
        textField.font = UIFont(name: "OpenSans-BoldItalic", size: 16.9)
        textField.staticPadding(leftPadding: 5,rightPadding: 5)
        return textField
    }()
    
    lazy var defaultSearchLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-BoldItalic", size: 13)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        navigationController?.navigationBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.backgroundColor = .primaryColor
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return tableView
    }()
    
    lazy var leftView: UIView = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(menuClose))
        let view = UIView()
        view.addGestureRecognizer(gesture)
        view.backgroundColor = .clear
        return view
    }()
    
    var searchVM = MenuViewModel()
    var delegate: SearchDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVM.onUpdate = {
            self.tableView.reloadData()
        }
        setupHierarchy()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.tableView.scrollAnimate()
        }
    }
    
    @objc func menuClose() {
        searchVM.menuClose()
    }
    
    private func setupHierarchy() {
        view.addSubview(leftView)
        view.addSubview(contentView)
        contentView.addSubview(icon)
        contentView.addSubview(contentLabel)
        contentView.addSubview(search)
        contentView.addSubview(searchTextField)
        contentView.addSubview(tableView)
        contentView.addSubview(defaultSearchLabel)
        
        let screenHeight = UIScreen.main.bounds.height
        contentView.snp.makeConstraints { make in
            make.left.equalTo(leftView.snp.right)
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(6)
            make.width.equalTo(51.8)
            make.height.equalTo(51.8)
        }
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.left.equalTo(icon.snp.right).offset(4)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(30)
        }
        search.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(screenHeight * 0.18)
            make.width.equalTo(26)
            make.height.equalTo(24)
        }
        searchTextField.snp.makeConstraints { make in
            make.centerY.equalTo(search.snp.centerY)
            make.left.equalTo(search.snp.right).offset(3)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(34)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        defaultSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        leftView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.52)
            make.height.equalToSuperview()
        }
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { fatalError("Don't create search cell") }
        let text = searchVM.modelAt(indexPath.row)
        cell.searchLabel.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let text = searchVM.modelAt(indexPath.row)
            searchVM.didSearch(text) { wallpaper in
                DispatchQueue.main.async {
                    if let delegate = self.delegate , let nav = self.navigationController {
                        delegate.didSearchShowResults(vm: wallpaper, nav: nav)
                        cell.flash()
                    }
                }
            }
        }
    }

}

extension MenuViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let currentText = text + string
        searchVM.getSimilar(currentText)
        defaultSearchLabel.text = "🔍  #\(currentText)"
        return true
    }
}
