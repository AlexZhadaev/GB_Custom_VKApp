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
    
    var count = 0
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        if count == 0 { UIView.transition(with: countLabel, duration: 0.75, options: .transitionFlipFromTop, animations: {self.count = self.count + 1})
            buttonImage.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            buttonImage.tintColor = UIColor.systemRed
            countLabel.textColor = UIColor.systemRed
        } else { UIView.transition(with: countLabel, duration: 0.75, options: .transitionFlipFromBottom, animations: {self.count = self.count - 1})
            buttonImage.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            buttonImage.tintColor = UIColor.systemBlue
            countLabel.textColor = UIColor.systemBlue
        }
        countLabel.text = "\(count)"
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
