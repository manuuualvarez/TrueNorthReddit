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
    
//    MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Height = \(self.view.frame.height)")
        print("Widt = \(self.view.frame.width)")
        setUpNavigationBar()
        setUpTableData()
        bind()
    }
    
    
//  MARK: - Observers
    private func bind(){
        viewModel.tableNewsData.observe(on: self) { [weak self] _ in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
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
        refreshControl.tintColor = .gray
        let attrStr = NSAttributedString(string:"Refreshing...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
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
        return viewModel.tableNewsData.value.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.tableNewsData.value
        let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        newsCell.configurationCell(news: data[indexPath.row])
        
        newsCell.sizeToFit()
        
        return newsCell
    }
    
    private func tableView(tableView: UITableView,
                   heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let title = viewModel.tableNewsData.value[indexPath.row].data?.title ?? ""
        let size = CGSize(width: view.frame.width , height: view.frame.height)
        let heightCell = NSString(string: title).boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return heightCell.height + 160
    }
    
    
}
