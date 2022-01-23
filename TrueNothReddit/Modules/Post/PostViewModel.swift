//
//  PostViewModel.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import Foundation


protocol PostViewModel: BaseViewModel {
    var url : String { get }
}

final class PostViewModelImplementation: BaseViewModelImplementation, PostViewModel {
//    MARK: Properties
    var url: String
    var name: String
    var navigator: PostNavigator?
    
    var readedItems: [PostReadEntity] = []
    
    init(url: String, name: String){
        self.url = url
        self.name = name
    }
    
    
    override func viewDidLoad() {
        getSavedPostData()
    }
    
    private func getSavedPostData() {
        readedItems = PersistenceService.getReadedPostCoreData()
        if !checkItemIsAlreadySaved() {
            savePostAsReadInCoreData()
        }
    }
    
    private func checkItemIsAlreadySaved() -> Bool {
        let data = readedItems.filter{ $0.name == self.name }
        return  data.count > 0
    }
    
    private func savePostAsReadInCoreData() {
        let readPost = PostReadEntity(context: PersistenceService.context)
        readPost.name = self.name
        PersistenceService.saveContext()
    }
    


}
