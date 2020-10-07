//
//  MyGroupsTableViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class MyGroupsTableViewController: UITableViewController {
    let groupService = GroupServices()
    var groups = [Item] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupService.getGroupData() { [weak self] groups in
                self?.groups = groups
                self?.tableView?.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupViewCell", for: indexPath) as! MyGroupsTableViewCell
        cell.configure(for: groups[indexPath.row])
        return cell
    }
    
}
