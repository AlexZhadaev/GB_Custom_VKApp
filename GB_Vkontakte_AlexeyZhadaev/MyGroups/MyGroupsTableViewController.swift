//
//  MyGroupsTableViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit
import CoreData

class MyGroupsTableViewController: UITableViewController {
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

extension MyGroupsTableViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller:
      NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller:
      NSFetchedResultsController<NSFetchRequestResult>,
      didChange sectionInfo: NSFetchedResultsSectionInfo,
      atSectionIndex sectionIndex: Int,
      for type: NSFetchedResultsChangeType) {

      let indexSet = IndexSet(integer: sectionIndex)

      switch type {
      case .insert:
        tableView.insertSections(indexSet, with: .automatic)
      case .delete:
        tableView.deleteSections(indexSet, with: .automatic)
      default: break
      }
    }

    func controller(_ controller:
                        NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            
        case .update:
            let cell = tableView.cellForRow(at: indexPath!) as! MyGroupsTableViewCell
            cell.configure(for: fetchedResultsController.object(at: indexPath!))

        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        @unknown default:
            print("Unexpected NSFetchedResultsChangeType")
        }
    }

    func controllerDidChangeContent(_ controller:
      NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
