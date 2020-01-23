//
//  File.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

class SearchResponseModel: Codable {
    
    let results: [GameModel]?
    
}

class GameModel: Codable {
    
    let id: Int?
    let background_image: String?
    let name: String?
    let metacritic: Int?
    let slug: String?
    let genres: [GameGenre]?
    let description: String?
    let website: String?
    let reddit_url: String?
    
}

class GameGenre: Codable {
    
    let name: String?
    
}
