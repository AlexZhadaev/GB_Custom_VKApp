//
//  FriendPhotoCollectionViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class FriendPhotoCollectionViewController: UICollectionViewController {
    
    var friend: Friend!
    
    var photos = [UIImage]()
    
    var selectedIndexPath: IndexPath!
    
    fileprivate func createFriendGallery() {
        title = friend.name
        for image in friend.friendGallery {
            photos.append(UIImage(named: image)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFriendGallery()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.friendGallery.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotoCollectionViewCell
        cell.photo.image = UIImage(named: friend.friendGallery[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let galleryViewController = storyboard?.instantiateViewController(identifier: "GalleryViewControllerKey") as! GalleryViewController
        self.selectedIndexPath = indexPath
        galleryViewController.photos = self.photos
        galleryViewController.currentIndex = self.selectedIndexPath.row
        galleryViewController.title = self.title
        self.show(galleryViewController, sender: nil)
    }
    
}
