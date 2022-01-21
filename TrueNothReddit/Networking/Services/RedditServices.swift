//
//  RedditServices.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import Foundation

class RedditService {
    
//    MARK: - Request:
    private func fetchNewsRequest() -> RequestSettings {
        let url: String = "https://www.reddit.com/top.json"
        
        return RequestConfigurationFactory.createRequestSettings(encodingType: .body,
                                                                 url: url,
                                                                 method: .get)
    }
    
    private func fetchNewsWithPageRequest(id: String) -> RequestSettings {
        let url: String = "https://www.reddit.com/top.json?&after=\(id)"
        
        return RequestConfigurationFactory.createRequestSettings(encodingType: .body,
                                                                 url: url,
                                                                 method: .get)
    }

//  MARK: - API Call:
    func getNews(completion: @escaping(Result<Welcome, ServiceError>) -> Void){
        APIManager.execute(resource: fetchNewsRequest(), type: Welcome.self) { (result) in
            switch result {
                case .success(let news):
                    completion(.success(news))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getNextPageData(id: String, completion: @escaping(Result<Welcome, ServiceError>) -> Void) {
        APIManager.execute(resource: fetchNewsWithPageRequest(id: id), type: Welcome.self) { (result) in
            switch result {
                case .success(let news):
                    completion(.success(news))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
