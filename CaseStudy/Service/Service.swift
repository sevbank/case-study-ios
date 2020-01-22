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
    let baseURL = "https://api.rawg.io/api/games?page_size=10&page=1"
//    fileprivate init() {}
    
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
