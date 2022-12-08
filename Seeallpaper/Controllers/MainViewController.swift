//
//  MainViewController.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import UIKit
import SnapKit


class MainViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    lazy var collectionView: UICollectionView = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(pressWallpaper))
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray6
        collectionView.addGestureRecognizer(gesture)
        collectionView.register(WallpaperCell.self, forCellWithReuseIdentifier: WallpaperCell.identifier)
        return collectionView
    }()
    
    var index = 0
    
    var wallpaperListVM =  WallpaperListViewModel()
    var delegate: ShowPaperDelegate?
    var delegatePop: ShowPaperPopDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupUI()
        setupHierarchy()
    }
    
    func initViewModel() {
        wallpaperListVM.updateTable = {
            self.collectionView.reloadData()
        }
        wallpaperListVM.hideLoading = {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemGray6
        navigationItem.title = TitleController.main.rawValue
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tappedSearch))
    }
    
    func setupHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(statusBarNavigationHeight + 10)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func addPage() {
        wallpaperListVM.addPage()
    }
    
    @objc func pressWallpaper(gesture: UITapGestureRecognizer) {
        guard let delegate = self.delegatePop, let navigationController = self.navigationController else { return }
        switch gesture.state {
        case .began:
            let location = gesture.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: location) {
                let vm = wallpaperListVM.modelAt(indexPath.section, indexPath.row)
                delegate.pressLongItemShowPaper(vm: vm, nav: navigationController)
            }
        case .ended:
            delegate.stopShowItem(nav: navigationController)
        @unknown default: break
        }
    }
    
    @objc private func tappedSearch() {
        wallpaperListVM.tappedSearch()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return wallpaperListVM.numberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpaperListVM.numberOfRows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperCell.identifier, for: indexPath) as? WallpaperCell else { fatalError() }
        let model = wallpaperListVM.modelAt(indexPath.section,indexPath.row)
        cell.update(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > index {
            index += 1
            if index % 70 == .zero {
                index = .zero
                addPage()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate, let nav = self.navigationController {
            let vm = wallpaperListVM.modelAt(indexPath.section, indexPath.row)
            delegate.pressItemShowPaper(vm: vm,nav: nav)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30 ) / 2 , height: collectionView.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
}




