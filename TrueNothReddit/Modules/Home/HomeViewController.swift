//
//  HomeViewController.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import UIKit

class HomeViewController: BaseViewController {
    
//    MARK: - UI Components
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    override var baseViewModel: BaseViewModel {
        return viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpTableData()
    }
    
    
//    MARK: - Methods
    
    private func setUpNavigationBar(){
        self.navigationController?.navigationBar.topItem?.title = "Reddit"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setUpTableData() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "NewsTableViewCell",bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "newsCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .yellow
        let attrStr = NSAttributedString(string:"Pull to refresh", attributes: [NSAttributedString.Key.foregroundColor : UIColor.yellow])
        refreshControl.attributedTitle = attrStr
        refreshControl.addTarget(self, action: #selector(self.userDidRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
//    MARK: - Obj C
    @objc private func userDidRefresh() {
        
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        newsCell.configurationCell(title: "Hello Word!")
        return newsCell
    }
    
    
}
