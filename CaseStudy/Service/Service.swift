//
//  Service.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    let baseURL = "https://api.rawg.io/api/games"
    let ad = "https://api.rawg.io/api/games?page_size=10&page=1gtav "
//    fileprivate init() {}
    
    func fetchGameDetail(with ID: Int, completion:@escaping (GameModel?, Error?) -> ()) {
        let url = baseURL + "/\(ID)"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func fetchFavoriteGames(completion: @escaping ([GameModel]?, Error?) -> ()) {
        var games: [GameModel] = []
        let dispatchGroup = DispatchGroup()
        let IDs: [Int]? = FavouriteService.shared.fetchFavouriteGames()
        IDs?.forEach { (ID) in
            dispatchGroup.enter()
            self.fetchGameDetail(with: ID) { (gameModel, error) in
                if let gameModel = gameModel {
                    games.append(gameModel)
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(games, nil)
        }
    }
    
    func fetchGames(with terms: String, pageSize: Int, page: Int, completion:@escaping (SearchResponseModel?, Error?) -> ()) {
        let url = baseURL + "?page_size=\(pageSize)&page=\(page)" + "&search=\(terms)"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func fetchGames(completion:@escaping (SearchResponseModel?, Error?) -> ()) {
        fetchGenericJSONData(urlString: baseURL, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
}
