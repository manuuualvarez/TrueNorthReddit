//
//  HomeViewModel.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//
import Foundation
import UIKit
import Photos


protocol HomeViewModel: BaseViewModel {
    var tableNewsData: TrueNorthObservable<[Child]> { get }
    func pullToRefres()
    func getDataFromNextPage()
    func goToPost(index: Int)
    func savePhotoInGallery(image: UIImage)
}


final class HomeViewModelImplementation: BaseViewModelImplementation, HomeViewModel {
    
//    MARK: Properties
    var navigator: HomeNavigator?
    var tableNewsData: TrueNorthObservable<[Child]> = TrueNorthObservable([])
    var afterPage = ""
    
//    MARK: Service
    var redditServices = RedditService()
    
//    MARK: Life cycle
    override func viewDidLoad() {
        fetchRedditData()
    }
    
//    MARK: Methods
    private func fetchRedditData() {
        isLoadingObservable.value = true
        redditServices.getNews { [weak self] (result) in
            self?.isLoadingObservable.value = false
            switch result {
                case .failure(_):
                    print("DEBUG: - Error fail")
                case .success(let news):
                    guard let data = news.data?.children  else { return }
                    self?.setNextPageQuery(response: news)
                    self?.tableNewsData.value = data
            }
        }
    }
    
    func pullToRefres() {
        tableNewsData.value = []
        fetchRedditData()
    }
    
    func getDataFromNextPage() {
        guard afterPage != "" else { return }
        
        isLoadingObservable.value = true
        redditServices.getNextPageData(id: afterPage, completion: { [weak self] (result) in
            self?.isLoadingObservable.value = false
            switch result {
                case .failure(_):
                    print("DEBUG: - Handle Request Error")
                case .success(let news):
                    guard let data = news.data?.children  else { return }
                    self?.setNextPageQuery(response: news)
                    self?.tableNewsData.value.append(contentsOf: data)
            }
        })
    }
    
    private func setNextPageQuery(response: Welcome) {
        if let after = response.data?.after {
            self.afterPage = after
        } else {
            self.afterPage = ""
        }
    }
    
    func savePhotoInGallery(image: UIImage) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { [weak self] (status) in
                switch status {
                    case .notDetermined, .restricted, .denied, .limited :
                        self?.navigator?.navigate(to: .getPermissions(image: image))
                    case .authorized:
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        self?.navigator?.navigate(to: .showSuccessDownloadImage)
                    @unknown default:
                        print("unknown")
                }
            }
        }
    }
    

//    MARK: Navigation
    
    func goToPost(index: Int) {
        guard let dataUrl = tableNewsData.value[index].data?.name,
              let components = dataUrl.components(separatedBy: "_").last,
              let name = tableNewsData.value[index].data?.name
                else { return }
    
        let url = "https://redd.it/\(components)"
        self.navigator?.navigate(to: .goToPost(url: url, name: name))
    }
    
}
