//
//  MyFriendsTableViewCell.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class MyFriendsTableViewCell: UITableViewCell {
    @IBOutlet weak var customAvatarView: CustomAvatarView!
    @IBOutlet weak var friendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for model: User) {
        friendName.text = "\(model.firstName ?? "") \(model.lastName ?? "")"
        customAvatarView.avatarImage.load(url: URL(string: model.avatar!)!)
        customAvatarView.configure()
    }
    
    @IBAction func animationButton(_ sender: Any) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.6
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 0.8
        self.customAvatarView.layer.add(animation, forKey: nil)
    }
}
