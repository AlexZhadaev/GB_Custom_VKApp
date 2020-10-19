//
//  FriendPhotoCollectionViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit
import CoreData

class FriendPhotoCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    let saveService = CoreDataSaveService()
    let photoService = Photo()
    var photos = [PhotoEntity]()
    var friend: UserEntity!
    var selectedIndexPath: IndexPath!
    var fetchedResultsController: NSFetchedResultsController<Photo>!
    var commitPredicate: NSPredicate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(friend.firstName ) \(friend.lastName )"
        photoService.getPhotoData()
        loadSavedData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotoCollectionViewCell
        cell.configure(for: fetchedResultsController.object(at: indexPath))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let galleryViewController = storyboard?.instantiateViewController(identifier: "GalleryViewControllerKey") as! GalleryViewController
        self.selectedIndexPath = indexPath
        galleryViewController.photos = fetchedResultsController.fetchedObjects!
        galleryViewController.currentIndex = self.selectedIndexPath.row
        galleryViewController.title = self.title
        self.show(galleryViewController, sender: nil)
    }
    
    func loadSavedData() {
        if fetchedResultsController == nil {
            let request = Photo.createFetchRequest()
            let sort = NSSortDescriptor(key: "url", ascending: false)
            request.sortDescriptors = [sort]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: saveService.storeStack.context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        
        fetchedResultsController.fetchRequest.predicate = commitPredicate
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            do {
                try self.fetchedResultsController.performFetch()
                self.collectionView.reloadData()
            } catch {
                print("Fetch failed")
            }
        }
    }
}
