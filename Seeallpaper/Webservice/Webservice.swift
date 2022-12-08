//
//  Webservice.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import Foundation

enum NetworkingError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Decodable> {
    let url: URL
    var method: HttpMethod = .get
    var parse: (Data) -> T?
}

struct Webservice {
    static let shared = Webservice()
    
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> Void) {
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = ["Authorization": "563492ad6f917000010000017e920007aebc4479aa5850ef7cc663f1"]
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(resource.parse(data))
            } else {
                print(NetworkingError.urlError)
            }
        }.resume()
    }
}
