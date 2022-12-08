//
//  ShowSearchViewModel.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 6.12.2022.
//

import Foundation

class ShowSearchViewModel {
    
    private var wallpapers: Wallpaper
    var coordinator: SearchCoordinator?
    
    init(_ wallpapers: Wallpaper) {
        self.wallpapers = wallpapers
    }
    
    func numberOfRows() -> Int {
        return self.wallpapers.photos.count
    }
    
    func modelAt(_ indexPath: Int) -> WallpaperModel {
        let model = WallpaperModel(paper: self.wallpapers.photos[indexPath])
        return model
    }
    
    func tappedSearch() {
        coordinator?.tappedSearch()
    }
    
    func tappedBack() {
        coordinator?.tappedBack()
    }
    
}
