//
//  FriendPhotoCollectionViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class FriendPhotoCollectionViewController: UICollectionViewController {
    let saveService = CoreDataSaveService()
    let photoService = Photo()
    var photos = [PhotoEntity]()
    var friend: UserEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        photoService.getPhotoData(completion: {
            self.saveService.readPhotoList() { [unowned self] photos in
                self.photos = photos
                self.collectionView?.reloadData()
            }
        })
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
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotoCollectionViewCell
        cell.configure(for: photos[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let galleryViewController = storyboard?.instantiateViewController(identifier: "GalleryViewControllerKey") as! GalleryViewController
        galleryViewController.photos = self.photos
        galleryViewController.currentIndex = indexPath.row
        galleryViewController.title = self.title
        self.show(galleryViewController, sender: nil)
    }
    
    func configure() {
        title = "\(friend?.firstName ?? "FirstName") \(friend?.lastName ?? "LastName")"
    }
}
