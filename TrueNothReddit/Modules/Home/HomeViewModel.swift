//
//  HomeViewModel.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//
import Foundation


protocol HomeViewModel: BaseViewModel {
    var tableNewsData: TrueNorthObservable<[Child]> { get }
    func pullToRefres()
}


final class HomeViewModelImplementation: BaseViewModelImplementation, HomeViewModel {

    
//    MARK: Properties
    var navigator: HomeNavigator?
    var tableNewsData: TrueNorthObservable<[Child]> = TrueNorthObservable([])
    
//    MARK: Service
    var redditServices = RedditService()
    
    override func viewDidLoad() {
        fetchRedditData()
    }
    
    private func fetchRedditData() {
        isLoadingObservable.value = true
        redditServices.getNews { [weak self] (result) in
            self?.isLoadingObservable.value = false
            switch result {
                case .failure(_):
                    print("DEBUG: - Error fail")
                case .success(let news):
                    guard let data = news.data?.children  else { return }
                    self?.tableNewsData.value = data
            }
        }
    }
    
    func pullToRefres() {
        tableNewsData.value = []
        fetchRedditData()
    }
    
    
}
