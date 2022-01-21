//
//  PostNavigator.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import UIKit

class PostNavigator : BaseNavigator{

    private var navigation: UINavigationController? {
        return view?.navigationController
    }

    enum Destination {
    }

    func navigate(to destination: PostNavigator.Destination) {
        switch destination {
        default:
//            uncoment next line
            print("")
        }
    }
}
