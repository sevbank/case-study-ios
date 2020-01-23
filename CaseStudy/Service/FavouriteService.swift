//
//  FavouriteService.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

class FavouriteService {
    
    static let shared = FavouriteService()
    let userDefaults = UserDefaults.standard
    let GAMES = "games"
    
    func isGameFavourite(ID: Int) -> Bool {
        var isFavourite = false
        if let list = self.userDefaults.object(forKey: GAMES) as? [Int] {
            list.forEach { (savedID) in
                if savedID == ID {
                    isFavourite = true
                }
            }
            return isFavourite
        }
        return isFavourite
    }
    
    func fetchFavouriteGames() -> [Int]? {
        if let list = self.userDefaults.object(forKey: GAMES) as? [Int] {
            return list
        }
        return []
    }
    
    func saveFavourite(with ID: Int) {
        if var list = userDefaults.object(forKey: GAMES) as? [Int] {
            list.append(ID)
            self.userDefaults.set(list, forKey: GAMES)
        } else {
          let newList = [ID]
            self.userDefaults.set(newList, forKey: GAMES)
        }
    }
    
    func deleteFavourite(with ID: Int) {
        if var list = userDefaults.object(forKey: GAMES) as? [Int] {
            list.remove(element: ID)
            self.userDefaults.set(list, forKey: GAMES)
        }
    }
    
}
