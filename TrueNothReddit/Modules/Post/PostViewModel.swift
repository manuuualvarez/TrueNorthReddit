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
    var navigator: PostNavigator?
    
    init(url: String){
        self.url = url
    }

}
