//
//  ShowSearchViewController.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 6.12.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(pressWallpaper))
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(gesture)
        collectionView.register(WallpaperCell.self, forCellWithReuseIdentifier: WallpaperCell.identifier)
        return collectionView
    }()
    
    var delegate: ShowPaperDelegate?
    var delegatePop: ShowPaperPopDelegate?
    var showSearchVM : ShowSearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupHierarchy()
        
    }
    
    func setupUI() {
        view.backgroundColor = .systemGray6
        navigationItem.title = TitleController.search.rawValue
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tappedSearch))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",style: .done, target: self, action: #selector(tappedClose))
    }
    
    func setupHierarchy() {
        view.addSubview(collectionView)
     
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(statusBarNavigationHeight * 1.5 + 10)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func tappedSearch() {
        showSearchVM.tappedSearch()
    }
    
    @objc private func tappedClose() {
        showSearchVM.tappedBack()
    }
    
    @objc func pressWallpaper(gesture: UITapGestureRecognizer) {
        guard let delegate = self.delegatePop, let navigationController = self.navigationController else { return }
        switch gesture.state {
        case .began:
            let location = gesture.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: location) {
                let vm = showSearchVM.modelAt(indexPath.row)
                delegate.pressLongItemShowPaper(vm: vm,nav: navigationController)
            }
        case .ended:
            delegate.stopShowItem(nav: navigationController)
        @unknown default: break
        }
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showSearchVM.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperCell.identifier, for: indexPath) as? WallpaperCell else { fatalError() }
        let model = showSearchVM.modelAt(indexPath.row)
        cell.update(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate, let nav = self.navigationController {
            let vm = showSearchVM.modelAt(indexPath.row)
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


