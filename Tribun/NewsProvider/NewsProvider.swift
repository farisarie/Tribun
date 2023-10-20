//
//  NewsProvider.swift
//  Tribun
//
//  Created by yoga arie on 16/10/23.
//

import Foundation
import Alamofire

class NewsProvider {
    static var shared: NewsProvider = NewsProvider()
    private init() {}
    
    let baseUrl = "https://berita-indo-api-next.vercel.app/api/tribun-news/jogja/techno"

    func listNews(_ completion: @escaping (Result<[Datum], Error>) -> Void) {
        AF.request(
            baseUrl,
            method: .get)
        .responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let news = try JSONDecoder().decode(News.self, from: data)
                    completion(.success(news.data))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
