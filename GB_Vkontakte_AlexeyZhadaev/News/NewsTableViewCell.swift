//
//  NewsTableViewCell.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 31.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var authorAvatar: UIImageView!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLikeCount: UILabel!
    @IBOutlet weak var buttonImage: UIButton!
    
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func likeButtonDidPressed(_ sender: Any) {
        if count == 0 {
            count = count + 1
            buttonImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            buttonImage.tintColor = UIColor.systemRed
            newsLikeCount.textColor = UIColor.systemRed
        } else { count = count - 1
            buttonImage.setImage(UIImage(systemName: "heart"), for: .normal)
            buttonImage.tintColor = UIColor.systemBlue
            newsLikeCount.textColor = UIColor.systemBlue
        }
        newsLikeCount.text = "\(count)"
    }
    
    
    @IBAction func commentButtonDidPressed(_ sender: Any) {
    }
    
    @IBAction func shareButtonDidPressed(_ sender: Any) {
    }
    
}
