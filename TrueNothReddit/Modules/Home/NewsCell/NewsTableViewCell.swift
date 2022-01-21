//
//  NewsTableViewCell.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import UIKit
import Kingfisher

protocol ImageDidTouch {
    func imageDidTouch(image: UIImage)
}

class NewsTableViewCell: UITableViewCell, ImageDidTouch {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfCommets: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var readStatusLabel: UILabel!
    
    var delegate: ImageDidTouch?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configurationCell(news: Child) {
        self.titleLabel.text = news.data?.title ?? "This post not contain title"
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .justified
        self.authorLabel.text = news.data?.author ?? "This post not contain author"
        self.authorLabel.textAlignment = .left
        
        if let urlString = news.data?.thumbnail, let url = URL(string: urlString) {
            postImageView.kf.setImage(with: url)
            let touchGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            postImageView.addGestureRecognizer(touchGesture)
            postImageView.isUserInteractionEnabled = true
            if !urlString.contains("http") {
                let image = UIImage(named: "emptyPhoto")
                postImageView.image = image
                postImageView.isUserInteractionEnabled = false
                postImageView.addGestureRecognizer(touchGesture)
            }
        } else {
            postImageView.image = UIImage(named: "emptyPhoto")
        }
        
        numberOfCommets.text = "Comments: \(news.data?.numComments ?? 0)"
        numberOfCommets.font = UIFont.boldSystemFont(ofSize: 10)
        
        if let dateInt = news.data?.createdUTC {
            let date = Date(timeIntervalSince1970: Double(dateInt))
            let dateString = timeAgoSinceDate(date: date, currentDate: Date(), numericDates: true)
            dateLabel.text = dateString
            dateLabel.font = UIFont.boldSystemFont(ofSize: 10)
        }
        
        readStatusLabel.text = "Unread"
        readStatusLabel.font = UIFont.boldSystemFont(ofSize: 10)
        readStatusLabel.textColor = .lightGray
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let image = postImageView.image else { return }
        imageDidTouch(image: image )
    }
    
    internal func imageDidTouch(image: UIImage) {
        delegate?.imageDidTouch(image: image)
    }
    
    private func showPermissionsAlert() {
        let alert = UIAlertController(title: "Allow Photo Access", message: "To save the image, we need access to your photo roll, please check", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
    }

    
    
}
