//
//  NewsTableViewCell.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 31.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var authorAvatar: UIImageView!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsPhotos: UICollectionView!
    @IBOutlet weak var newsLikeCount: UILabel!
    @IBOutlet weak var buttonImage: UIButton!
    
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.newsPhotos.dataSource = self
        self.newsPhotos.delegate = self
        self.newsPhotos.register(UINib.init(nibName: "NewsPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsPhotoXibKey")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
            
        authorAvatar.clipsToBounds = true
        authorAvatar.layer.cornerRadius = authorAvatar.frame.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsAuthor.text = nil
        authorAvatar.image = nil
        newsLabel.text = nil
        newsDate.text = nil
        newsLikeCount.text = "0"
        newsLikeCount.textColor = UIColor.systemBlue
        buttonImage.setImage(UIImage(systemName: "heart"), for: .normal)
        buttonImage.tintColor = UIColor.systemBlue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsPhotoXibKey", for: indexPath as IndexPath) as! NewsPhotoCollectionViewCell

        return cell
    }
    
    @IBAction func likeButtonDidPressed(_ sender: Any) {
        if count == 0 { UIView.transition(with: newsLikeCount, duration: 0.75, options: .transitionFlipFromTop, animations: {self.count = self.count + 1})
            buttonImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            buttonImage.tintColor = UIColor.systemRed
            newsLikeCount.textColor = UIColor.systemRed
        } else { UIView.transition(with: newsLikeCount, duration: 0.75, options: .transitionFlipFromBottom, animations: {self.count = self.count - 1})
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
