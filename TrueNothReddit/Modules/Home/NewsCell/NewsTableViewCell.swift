//
//  NewsTableViewCell.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/21/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    
    func configurationCell(title: String) {
        newsTitle.text = title
    }
}
