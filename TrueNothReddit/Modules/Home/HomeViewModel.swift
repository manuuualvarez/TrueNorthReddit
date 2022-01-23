//
//  HomeViewModel.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//
import Foundation
import UIKit
import Photos
import SwiftUI

struct EditPostModel {
    let name: String
    var isSelected: Bool
}


protocol HomeViewModel: BaseViewModel {
    var tableNewsData: TrueNorthObservable<[Child]> { get }
    func pullToRefres()
    func getDataFromNextPage()
    func goToPost(index: Int)
    func savePhotoInGallery(image: UIImage)
    func deletePost(index: Int)
    func removeAllPostDidTapped()
    var showBtnToCleanCoreData: TrueNorthObservable<Bool> { get }
    func clearCoreDataDidTouch()
}


final class HomeViewModelImplementation: BaseViewModelImplementation, HomeViewModel {

//    MARK: Properties
    var navigator: HomeNavigator?
    var tableNewsData: TrueNorthObservable<[Child]> = TrueNorthObservable([])
    var afterPage = ""
    var readedItems: [PostReadEntity] = []
    var showBtnToCleanCoreData: TrueNorthObservable<Bool> = TrueNorthObservable(false)

//    MARK: Service
    var redditServices = RedditService()
    
//    MARK: Life cycle
    override func viewDidLoad() {
        deleteAllCoreData()
        fetchRedditData()
        showSettingsBtn()
    }
    
    override func viewWillAppear() {
        getSavedPostDataAndCheckIfReadOrDeleted(isFromNextPage: false, isWithMemoryData: true)
    }
    
//    MARK: Methods
    private func fetchRedditData() {
        animationName = .loader
        isLoadingObservable.value = true
        redditServices.getNews { [weak self] (result) in
            self?.isLoadingObservable.value = false
            switch result {
                case .failure(_):
                    print("DEBUG: - Error fail")
                case .success(let news):
                    guard let data = news.data?.children  else { return }
                    self?.setNextPageQuery(response: news)
                    self?.getSavedPostDataAndCheckIfReadOrDeleted(data: data, isFromNextPage: false)
            }
        }
    }
    
    func pullToRefres() {
        tableNewsData.value = []
        fetchRedditData()
    }
    
    func getDataFromNextPage() {
        guard afterPage != "" else { return }
        animationName = .loader
        isLoadingObservable.value = true
        redditServices.getNextPageData(id: afterPage, completion: { [weak self] (result) in
            self?.isLoadingObservable.value = false
            switch result {
                case .failure(_):
                    print("DEBUG: - Handle Request Error")
                case .success(let news):
                    guard let data = news.data?.children  else { return }
                    self?.setNextPageQuery(response: news)
                    self?.getSavedPostDataAndCheckIfReadOrDeleted(data: data, isFromNextPage: true)
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
    
    private func getSavedPostDataAndCheckIfReadOrDeleted(data: [Child] = [], isFromNextPage: Bool, isWithMemoryData: Bool = false) {
        readedItems = PersistenceService.getReadedPostCoreData()
        var postArray: [Child] = []

        if !isWithMemoryData {
             postArray = data.map{ element -> Child in
                var post: Child = element
                post.data?.isRead = readedItems.filter{ $0.name == element.data?.name }.count > 0
                return post
            }
        } else {
            postArray = tableNewsData.value.map{ element -> Child in
                var post: Child = element
                post.data?.isRead = readedItems.filter{ $0.name == element.data?.name }.count > 0
                return post
            }
        }
        
        let deletedItems = fetchTrashPost()
        postArray.removeAll { (post) in
            guard let name = post.data?.name, let itemsDeleted = deletedItems else { return false }
            return itemsDeleted.contains{ $0.name == name }
        }
        
        if isFromNextPage {
            tableNewsData.value.append(contentsOf: postArray)
        } else {
            tableNewsData.value = postArray
        }
    }
    
    func deletePost(index: Int) {
        guard let data = tableNewsData.value[index].data else { return }
        saveTrashInCoreData(data: data)
        tableNewsData.value.remove(at: index)
    }
    
    private func saveTrashInCoreData(data: ChildData){
        guard let name = data.name else { return }
        let trash = TrashedEntity(context: PersistenceService.context)
        trash.name = name
        PersistenceService.saveContext()
        showSettingsBtn()
    }
    
    private func fetchTrashPost() -> [TrashedEntity]? {
        return PersistenceService.getDeletedPostCoreData()
    }
            
    internal func removeAllPostDidTapped() {
        animationName = .removeLoader
        isLoadingObservable.value = true
        for i in 0...(tableNewsData.value.count - 1) {
            let trash = TrashedEntity(context: PersistenceService.context)
            guard let item = tableNewsData.value[i].data?.name else { return }
            trash.name = item
            PersistenceService.saveContext()
        }
        tableNewsData.value = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoadingObservable.value = false
            self.showSettingsBtn()
            self.getDataFromNextPage()
        }
    }
    
    private func deleteAllCoreData() {
        PersistenceService.deleteAllData(.trashPostEntity)
        PersistenceService.deleteAllData(.postReadEntity)
        PersistenceService.saveContext()
        showSettingsBtn()
        getDataFromNextPage()
    }
    
    private func showSettingsBtn() {
        showBtnToCleanCoreData.value = fetchTrashPost()?.count ?? 0 > 0 || readedItems.count > 0
    }
    
    func clearCoreDataDidTouch() {
        deleteAllCoreData()
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
