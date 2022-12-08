//
//  WallpaperListViewModel.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 4.12.2022.
//

import Foundation
import Kingfisher

class WallpaperListViewModel {
    
    var coordinator: MainCoordinator?
    var delegate: ServiceDelegate?
    var allPaper = [Wallpaper]()
    var wallpaperModels = [WallpaperModel]()
    var updateTable = {}
    var hideLoading = {}
    
    
    func responseService() {
        if let delegate = delegate {
            let resource = Resource<Wallpaper>(url: Constants.Urls.Url(.curated)) { data in
                let results = try? JSONDecoder().decode(Wallpaper.self, from: data)
                return results
            }
            delegate.getService(resource: resource) { wallpaper in
                DispatchQueue.main.async {
                    self.allPaper.append(wallpaper)
                    self.hideLoading()
                    self.updateTable()
                }
            }
        }
    }
    
    func addPage() {
        selectedPage = selectedPage + 1
        if selectedPage >  100 {
            let random = Int.random(in: 0...100)
            selectedPage = random
        }
        self.responseService()
    }
    
    func numberOfSections() -> Int {
        return self.allPaper.count
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.allPaper[section].photos.count
    }
    
    func modelAt(_ section: Int, _ index: Int) -> WallpaperModel {
        let model = allPaper[section].photos[index]
        return WallpaperModel(paper: model)
    }
    
    var selectedPage: Int {
        get {
            var page = 0
            let userDefaults = UserDefaults.standard
            if let value = userDefaults.value(forKey: "random") as? Int {
                page = value
            }
            return page
        }
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(newValue, forKey: "random")
        }
    }
    
    func getResource() {
        let resource = Resource<Wallpaper>(url: Constants.Urls.Url(.curated)) { data in
            let results = try? JSONDecoder().decode(Wallpaper.self, from: data)
            return results
        }
        Webservice.shared.load(resource: resource) { wallpaper in
            guard let wallpaper = wallpaper else {return}
            DispatchQueue.main.async {
                self.allPaper.append(wallpaper)
                self.updateTable()
            }
        }
    }
    
    func tappedSearch() {
        coordinator?.tappedSearch()
    }
}

struct WallpaperModel {
    private let paper: Paper
    
    init(paper: Paper) {
        self.paper = paper
    }
    
    var url: URL {
        return URL(string: paper.src.medium)!
    }
    
    var urlLarge: URL {
        return URL(string: paper.src.large)!
    }
    
    var photographer: String {
        return " @\(paper.photographer)"
    }
    
    var color: UIColor {
        let hex = paper.avg_color.lowercased()
        return UIColor(hexaString: hex)
    }
    
    var userName: String {
        let url = paper.photographer_url.components(separatedBy: "@")
        return url[1]
    }
    
    var attrSubtitle: NSAttributedString {
        let text = "\(userName) \(paper.alt)"
        return text.replace(userName.count)
    }
    
}
