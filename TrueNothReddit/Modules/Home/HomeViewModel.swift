//
//  HomeViewModel.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import Foundation


protocol HomeViewModel: BaseViewModel {

}


final class HomeViewModelImplementation: BaseViewModelImplementation, HomeViewModel {
    
    var navigator: HomeNavigator?
}
