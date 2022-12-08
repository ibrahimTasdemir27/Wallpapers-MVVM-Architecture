//
//  SearchViewModel.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 6.12.2022.
//

import Foundation
import NaturalLanguage

class MenuViewModel {
    
    var coordinator: MenuCoordinator?
    var delegate: ServiceDelegate?
    var onUpdate = {}
    
    var searchResult = [(String,NLDistance)]()
    
    func getSimilar(_ text: String) {
        if let embedding = NLEmbedding.wordEmbedding(for: .english) {
            let similarWords = embedding.neighbors(for: text.lowercased(), maximumCount: 15)
            searchResult = similarWords
            onUpdate()
        }
    }
    
    func numberOfRows() -> Int {
        return searchResult.count
    }
    
    func modelAt(_ index: Int) -> String {
        return "#\(self.searchResult.reversed()[index].0)"
    }
    
    func menuClose() {
        coordinator?.menuClose()
    }
    
    func didSearch(_ text: String, completion: @escaping(Wallpaper) -> Void) {
        var text = text
        text.removeFirst()
        if let delegate = delegate {
            let resource = Resource<Wallpaper>(url: Constants.Urls.Url(.search, text)) { data in
                let results = try? JSONDecoder().decode(Wallpaper.self, from: data)
                return results
            }
            delegate.getService(resource: resource) { wallpaper in
                completion(wallpaper)
            }
        }
    }
    
}
