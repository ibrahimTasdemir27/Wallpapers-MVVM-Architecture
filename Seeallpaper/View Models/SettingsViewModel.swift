//
//  SettingsVM.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 7.12.2022.
//

import Foundation

class SettingsViewModel {
    
    let settingsItem = ["Dark Mode","Rate us", "Suggestions and opinions"]
    
    func numberOfRows() -> Int {
        return settingsItem.count
    }
    
    func modalAt(_ indexPath: Int) -> String {
        return settingsItem[indexPath]
    }
    
}
