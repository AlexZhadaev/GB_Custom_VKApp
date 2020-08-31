//
//  MyFriendsTableViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class MyFriendsTableViewController: UITableViewController {
    
    var friends: [Friend] = []
    var friendDictionary = [String: [Friend]]()
    var friendSection = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateFriends()
        sortFriends()
    }
    
    private func generateFriends() {
        let friend1 = Friend(name: "Гарольд Скрывающий Боль", friendPhoto: "avatarHarold", friendGallery: ["harold1"])
        let friend2 = Friend(name: "Александр Невский", friendPhoto: "avatarNevsky", friendGallery: ["nevsky1"])
        let friend3 = Friend(name: "Малыш Йода", friendPhoto: "avatarYoda", friendGallery: ["yoda1"])
        friends.append(friend2)
        friends.append(friend1)
        friends.append(friend3)
        
        tableView.reloadData()
    }
    
    private func sortFriends() {
        for user in friends {
            let key = "\(user.name[user.name.startIndex])".uppercased()
            if var userValue = self.friendDictionary[key] {
                userValue.append(user)
            } else {
                self.friendDictionary[key] = [user]
            }
            self.friendSection = [String](self.friendDictionary.keys).sorted()
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendKey = friendSection[section]
        if let friendValues = friendDictionary[friendKey] {
            return friendValues.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as! MyFriendsTableViewCell
        let friendKey = friendSection[indexPath.section]
        if let friend = friendDictionary[friendKey] {
            cell.configure(for: friend[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSection[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSection
    }
}
