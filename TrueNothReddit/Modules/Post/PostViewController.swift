//
//  PostViewController.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import UIKit
import WebKit

class PostViewController: BaseViewController {
    
//    MARK: - IBOutlets
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: PostViewModel!
    override var baseViewModel: BaseViewModel {
        return viewModel
    }
    
//    MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webViewConfiguration()
        self.restorationIdentifier = "PostViewController"
    }
    
//    MARK: - Methods:

    private func webViewConfiguration(){
        webView.uiDelegate = self
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        
        if let url = URL(string: viewModel.url){
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            let url = URL(string: "https://truenorth.co/")
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    }
}

extension PostViewController: UIWebViewDelegate, WKUIDelegate {
    
}

extension PostViewController {
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        coder.encode(webView.scrollView.contentOffset.y, forKey: "webView.contentOffset.y")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let webViewY = coder.decodeObject(forKey: "webView.contentOffset.y") as? CGFloat {
            webView.scrollView.contentOffset.y = webViewY
        }
    }
}
