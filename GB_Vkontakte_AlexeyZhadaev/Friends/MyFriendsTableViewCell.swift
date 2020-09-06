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
    
    func configure(for model: Friend) {
        friendName.text = model.name
        customAvatarView.avatarImage.image = UIImage.init(named: model.friendPhoto)
        customAvatarView.configure()
    }
}
