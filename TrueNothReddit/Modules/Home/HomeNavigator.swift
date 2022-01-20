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
    }

    func navigate(to destination: HomeNavigator.Destination) {
        switch destination {
        default:
//            uncoment next line
            print("")
        }
    }
}
