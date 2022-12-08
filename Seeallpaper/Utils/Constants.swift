//
//  Constants.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 4.12.2022.
//

import Foundation

struct Constants {
    
    struct Urls {
        static func Url(_ options: APIJobs , _ text: String = "") -> URL {
            var url = ""
            switch options {
            case .search:
                url = "https://api.pexels.com/v1/search?query=\(text)"
            case .curated:
                let userDefaults = UserDefaults.standard
                let page = userDefaults.value(forKey: "random")
                url = "https://api.pexels.com/v1/curated?page=\(page!)&per_page=80"
            }
            return URL(string: url)!
        }
    }
}
