//
//  FindGroupsController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 05.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class FindGroupsTableViewController: UITableViewController {
    let saveService = CoreDataService()
    let groupService = Group()
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupService.getSearchGroups()
        saveService.readGroupList() { [unowned self] groups in
                self.groups = groups
                self.tableView?.reloadData()
            }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupViewCell", for: indexPath) as! FindGroupsTableViewCell
        let group = groups[indexPath.row]
        cell.configure(for: group)
        return cell
    }

}
