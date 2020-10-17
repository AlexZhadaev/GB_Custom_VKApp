//
//  LikeCustomControlUIView.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 27.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class LikeCustomControlUIView: UIView {

    @IBOutlet var countLabel: UILabel!
    @IBOutlet var buttonImage: UIButton!
    
    var userLike: Int16!
    var count: Int16!
    
    func configure (for model: Photo) {
        userLike = model.userLikes
        if userLike == 1 {
            buttonImage.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            buttonImage.tintColor = UIColor.systemRed
            countLabel.textColor = UIColor.systemRed
        }
        count = model.likesCount
        countLabel.text = String(count)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        if userLike == 0 { UIView.transition(with: countLabel, duration: 0.75, options: .transitionFlipFromTop, animations: { self.count += 1 })
            buttonImage.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            buttonImage.tintColor = UIColor.systemRed
            countLabel.textColor = UIColor.systemRed
        } else { UIView.transition(with: countLabel, duration: 0.75, options: .transitionFlipFromBottom, animations: { self.count -= 1})
            buttonImage.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            buttonImage.tintColor = UIColor.systemBlue
            countLabel.textColor = UIColor.systemBlue
        }
        countLabel.text = "\(count ?? 0)"
    }

}
