//
//  MyFriendsTableViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 06.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class MyFriendsTableViewController: UITableViewController {
    let userService = User()
    let saveService = CoreDataSaveService()
    var friends = [UserEntity]()
    var friendDictionary = [String: [UserEntity]]()
    var friendSection = [String]()
    var filteredFriends = [UserEntity]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userService.getUserData(completion: {})
        saveService.readUserList() { [unowned self] friends in
            self.friends = friends
            self.sortFriends()
            self.searchControllerSetup()
            self.tableView?.reloadData()
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering =
            searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive &&
            (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    private func searchControllerSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    private func sortFriends() {
        for friend in friends {
            let friendKey = "\(friend.firstName[friend.firstName.startIndex])".uppercased()
            if var friendValues = friendDictionary[friendKey] {
                friendValues.append(friend)
                friendDictionary[friendKey] = friendValues
            } else {
                friendDictionary[friendKey] = [friend]
            }
            self.friendSection = [String](friendDictionary.keys).sorted()
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        } else {
            return friendSection.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredFriends.count
        } else {
            let friendKey = friendSection[section]
            if let friendValues = friendDictionary[friendKey] {
                return friendValues.count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as! MyFriendsTableViewCell
        if isFiltering {
            _ = filteredFriends[indexPath.row]
            cell.configure(for: filteredFriends[indexPath.row])
        } else {
            let friendKey = friendSection[indexPath.section]
            if let friendValues = friendDictionary[friendKey] {
                cell.configure(for: friendValues[indexPath.row])
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect())
        headerView.backgroundColor = .init(white: 0.9, alpha: 0.4)
        let label = UILabel(frame: CGRect(x: 15, y: 6, width: 50, height: 15))
        label.text = friendSection[section]
        headerView.addSubview(label)
        return headerView
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSection
    }
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            
            let selectedFriend = filteredFriends[indexPath.row]
            let friendPhotoController = storyboard?.instantiateViewController(identifier: "PhotoGalleryStoryboardKey") as! FriendPhotoCollectionViewController
            friendPhotoController.friend = selectedFriend
            Session.instance.userId = Int64(selectedFriend.id)
            self.show(friendPhotoController, sender: nil)
        } else {
            
            let selectedSection = friendSection[indexPath.section]
            let selectedFriend = friendDictionary[selectedSection]
            let friendPhotoController = storyboard?.instantiateViewController(identifier: "PhotoGalleryStoryboardKey") as! FriendPhotoCollectionViewController
            friendPhotoController.friend = selectedFriend![indexPath.row]
            Session.instance.userId = Int64(selectedFriend![indexPath.row].id)
            self.show(friendPhotoController, sender: nil)
        }
    }
    
    // MARK: - Search
    func filterContentForSearchText(_ searchText: String) {
        filteredFriends = friends.filter { (friend: UserEntity) -> Bool in
            if isSearchBarEmpty {
                return false
            } else {
                return (friend.firstName.lowercased().contains(searchText.lowercased()))
            }
        }
        tableView.reloadData()
    }
    
}
//MARK:- UISearch

extension MyFriendsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension MyFriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}
