//
//  Wallpaper.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import Foundation

enum APIJobs: String {
    case curated
    case search
}

struct Wallpaper: Decodable {
    let page: Int
    var per_page: Int
    var photos: [Paper]
}

struct Paper: Decodable{
    let photographer: String
    let src: Urls
    let alt: String
    let avg_color: String
    let photographer_url: String
}

struct Urls: Decodable {
    let medium: String
    let large: String
}
