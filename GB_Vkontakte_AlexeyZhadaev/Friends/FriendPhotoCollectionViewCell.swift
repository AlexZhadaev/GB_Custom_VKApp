//
//  FriendPhotoCollectionViewCell.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class FriendPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeCustomController: LikeCustomControlUIView!
    
    func configure(for model: PhotoItem) {
        likeCustomController.configure(for: model)
        photo.load(url: URL(string: model.sizes[4].url)!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeCustomController.buttonImage.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        likeCustomController.buttonImage.tintColor = UIColor.systemBlue
        likeCustomController.countLabel.textColor = UIColor.systemBlue
    }
}
