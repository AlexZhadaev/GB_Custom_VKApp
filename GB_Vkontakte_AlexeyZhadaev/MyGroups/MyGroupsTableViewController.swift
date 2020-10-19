//
//  MyGroupsTableViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit
import CoreData

class MyGroupsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let groupService = Group()
    let saveService = CoreDataSaveService()
    var groups = [GroupEntity]()
    var fetchedResultsController: NSFetchedResultsController<Group>!
    var commitPredicate: NSPredicate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupService.getGroupData()
        loadSavedData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupViewCell", for: indexPath) as! MyGroupsTableViewCell
        cell.configure(for: fetchedResultsController.object(at: indexPath))
        return cell
    }
    
    func loadSavedData() {
        if fetchedResultsController == nil {
            let request = Group.createFetchRequest()
            let sort = NSSortDescriptor(key: "name", ascending: false)
            request.sortDescriptors = [sort]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: saveService.storeStack.context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
        }
        
        fetchedResultsController.fetchRequest.predicate = commitPredicate
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            do {
                try self.fetchedResultsController.performFetch()
                self.tableView.reloadData()
            } catch {
                print("Fetch failed")
            }
        }
    }
}

//extension MyGroupsTableViewController: NSFetchedResultsControllerDelegate {
//
//    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
//        return sectionName
//    }
//
//    func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//
//    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
//        case .delete:
//            tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
//        default:
//            return
//        }
//    }
//
//    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//
//        switch type {
//        case .insert:
//            if let indexPath = newIndexPath {
//                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .automatic)
//            }
//        case .update:
//            if let indexPath = indexPath {
//                let product = fetchedResultsController.objectAtIndexPath(indexPath) as! Products
//                guard let cell = tableView.cellForRow(at: indexPath as IndexPath) else { break }
//                configureCell(cell, withObject: product)
//            }
//        case .move:
//            if let indexPath = indexPath {
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .automatic)
//            }
//            if let newIndexPath = newIndexPath {
//                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .automatic)
//            }
//        case .delete:
//            if let indexPath = indexPath {
//                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .automatic)
//            }
//        }
//    }
//
//    func controllerDidChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//}
