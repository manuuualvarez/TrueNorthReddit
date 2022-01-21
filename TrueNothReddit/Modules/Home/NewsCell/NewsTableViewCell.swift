//
//  NewsTableViewCell.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfCommets: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var readStatusLabel: UILabel!
    
    
    
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
            if !urlString.contains("http") {
                let image = UIImage(named: "emptyPhoto")
                postImageView.image = image
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
    
}
