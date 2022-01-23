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
        viewModel.showBtnToCleanCoreData.observe(on: self) { [weak self] _ in
            self?.setCleanCoreDataBtn()
        }
    }
    
//    MARK: - Methods
    private func setUpNavigationBar(){
        self.navigationController?.navigationBar.topItem?.title = "Reddit"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let removeBtn = UIBarButtonItem(title: "Remove All", style: .plain, target: self, action: #selector(removeAllPostTapped))
        removeBtn.tintColor = .red
        navigationItem.rightBarButtonItem = removeBtn
    }
    
    private func setCleanCoreDataBtn() {
        if viewModel.showBtnToCleanCoreData.value {
            let cleanCoreDataBtn = UIBarButtonItem(title: "Clean Core Data", style: .plain, target: self, action: #selector(cleanCoreDataTapped))
            cleanCoreDataBtn.tintColor = .red
            navigationItem.leftBarButtonItem = cleanCoreDataBtn
        } else {
            navigationItem.leftBarButtonItem = nil
        }
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
        viewModel.pullToRefres()
    }
    
    @objc private func removeAllPostTapped() {
        viewModel.removeAllPostDidTapped()
    }
    
    @objc private func cleanCoreDataTapped() {
        viewModel.clearCoreDataDidTouch()
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
        newsCell.delegate = self
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.tableNewsData.value.count - 3 == indexPath.row {
            viewModel.getDataFromNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToPost(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.transform = CGAffineTransform(rotationAngle: 180)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05,
            animations: {
                cell?.alpha = 0
                cell?.transform = CGAffineTransform(rotationAngle: 0.0)
            },
            completion: { _ in self.viewModel.deletePost(index: indexPath.row) })
    }
}

extension HomeViewController: ImageDidTouch {
    func imageDidTouch(image: UIImage) {
        viewModel.savePhotoInGallery(image: image)
    }
}
