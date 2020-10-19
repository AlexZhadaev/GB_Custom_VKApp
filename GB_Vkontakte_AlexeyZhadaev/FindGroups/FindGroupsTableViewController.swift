//
//  FindGroupsController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 05.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit
import CoreData

class FindGroupsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let saveService = CoreDataSaveService()
    let groupService = Group()
    var groups = [GroupEntity]()
    var fetchedResultsController: NSFetchedResultsController<Group>!
    var commitPredicate: NSPredicate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupService.getSearchGroups()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupViewCell", for: indexPath) as! FindGroupsTableViewCell
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
