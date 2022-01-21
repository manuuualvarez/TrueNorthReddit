//
//  HomeNavigator.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import UIKit

class HomeNavigator : BaseNavigator{

    private var navigation: UINavigationController? {
        return view?.navigationController
    }

    enum Destination {
        case goToPost(url: String)
    }

    func navigate(to destination: HomeNavigator.Destination) {
        switch destination {
            case .goToPost(let url):
                presentPost(url: url)
        }
    }
    
    private func presentPost(url: String){
        let vc = PostBuilder.build(url: url)
        vc.modalPresentationStyle = .overFullScreen
        self.navigation?.pushViewController(vc, animated: true)
    }
}
