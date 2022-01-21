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
        let url: String = "https://www.reddit.com/.json"
        
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
    
}
