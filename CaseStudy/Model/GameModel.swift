//
//  File.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

class SearchResponseModel: Codable {
    
    let results: [GameModel]
    
}

class GameModel: Codable {
    
    let background_image: String
    let name: String
    let metacritic: Int
    let genres: [GameGenre]
    
}

class GameGenre: Codable {
    
    let name: String
    
}
