//
//  PostBuilder.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import Foundation

class PostBuilder {
    static func build(url: String, name: String) -> PostViewController {
        let viewModel = PostViewModelImplementation(url: url, name: name)
        let controller = PostViewController()
        let navigator = PostNavigator()

        navigator.view = controller

        viewModel.navigator = navigator

        controller.viewModel = viewModel
        return controller
    }
}
