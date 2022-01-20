//
//  HomeViewController.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import UIKit

class HomeViewController: BaseViewController {

    var viewModel: HomeViewModel!
    override var baseViewModel: BaseViewModel {
        return viewModel
    }
    var navigator: HomeNavigator!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
