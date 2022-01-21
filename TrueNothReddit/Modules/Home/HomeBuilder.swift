//
//  HomeBuilder.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import Foundation

class HomeBuilder {
    static func build() -> HomeViewController {
        let viewModel = HomeViewModelImplementation()
        let controller = HomeViewController()
        let navigator = HomeNavigator()

        navigator.view = controller

        viewModel.navigator = navigator

        controller.viewModel = viewModel
        return controller
    }
}
