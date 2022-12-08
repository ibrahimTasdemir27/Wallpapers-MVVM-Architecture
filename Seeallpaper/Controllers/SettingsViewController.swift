//
//  SettingsViewController.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.backgroundColor = .systemGray6
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        return tableView
    }()
    
    let settingsVM = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupHierarchy()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        navigationItem.title = TitleController.settings.rawValue
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarNavigationHeight + 10)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsVM.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else { fatalError("Don't create cell") }
        let model = settingsVM.modalAt(indexPath.row)
        cell.settingsLabel.text = model
        if indexPath.row == .zero {
            cell.switchMode.isHidden = false
        }
        return cell
    }
}
