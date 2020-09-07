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
    var filteredFriends: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateFriends()
        sortFriends()
        
        let tapGesture = UITapGestureRecognizer()
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(taptap))
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
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
    
    private func generateFriends() {
        let friend1 = Friend(name: "Гарольд Скрывающий Боль", friendPhoto: "avatarHarold", friendGallery: ["avatarHarold","noAvatar"])
        let friend2 = Friend(name: "Александр Невский", friendPhoto: "avatarNevsky", friendGallery: ["nevsky1", "nevsky2", "nevsky3", "nevsky4", "nevsky5"])
        let friend3 = Friend(name: "Малыш Йода", friendPhoto: "avatarYoda", friendGallery: ["noAvatar", "noAvatar"])
        let friend4 = Friend(name: "Александр Пистолетов", friendPhoto: "noAvatar", friendGallery: ["noAvatar", "noAvatar"])
        let friend5 = Friend(name: "Гейб Ньюэлл", friendPhoto: "noAvatar", friendGallery: ["noAvatar", "noAvatar"])
        let friend6 = Friend(name: "Марк Дакаскос", friendPhoto: "noAvatar", friendGallery: ["noAvatar", "noAvatar"])
        let friend7 = Friend(name: "Сарик Андреасян", friendPhoto: "noAvatar", friendGallery: ["noAvatar", "noAvatar"])
        let friend8 = Friend(name: "Оливье Грюнер", friendPhoto: "noAvatar", friendGallery: ["noAvatar", "noAvatar"])
        let friend9 = Friend(name: "Каспер Ван Дин", friendPhoto: "noAvatar", friendGallery: ["noAvatar", "noAvatar"])
        let friend10 = Friend(name: "Дон Уилсон", friendPhoto: "noAvatar", friendGallery: ["noAvatar", "noAvatar"])
        let friend11 = Friend(name: "Маттиас Хьюз", friendPhoto: "noAvatar", friendGallery: ["noAvatar", "noAvatar"])
        friends.append(friend1)
        friends.append(friend2)
        friends.append(friend3)
        friends.append(friend4)
        friends.append(friend5)
        friends.append(friend6)
        friends.append(friend7)
        friends.append(friend8)
        friends.append(friend9)
        friends.append(friend10)
        friends.append(friend11)
        
        tableView.reloadData()
    }
    
    private func sortFriends() {
        for user in friends {
            let key = "\(user.name[user.name.startIndex])".uppercased()
            if var userValue = self.friendDictionary[key] {
                userValue.append(user)
                self.friendDictionary[key] = userValue
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
        if isFiltering {
            return filteredFriends.count
        }
        let friendKey = friendSection[section]
        if let userValue = friendDictionary[friendKey] {
            return userValue.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as! MyFriendsTableViewCell
        if isFiltering {
            let friend = filteredFriends[indexPath.row]
            cell.configure(for: filteredFriends[indexPath.row])
        } else {
            let friendKey = friendSection[indexPath.section]
            if let friend = friendDictionary[friendKey] {
                cell.configure(for: friend[indexPath.row])
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
        let whichIsSelected = indexPath.row
        let selectedFriend = friends[whichIsSelected]
        let friendPhotoController = storyboard?.instantiateViewController(identifier: "PhotoGalleryStoryboardKey") as! FriendPhotoCollectionViewController
        friendPhotoController.friend = selectedFriend
        self.show(friendPhotoController, sender: nil)
    }
    
    // MARK: - Search
    func filterContentForSearchText(_ searchText: String) {
        filteredFriends = friends.filter { (friend: Friend) -> Bool in
            
            if isSearchBarEmpty {
                return false
            } else {
                return friend.name.lowercased()
                    .contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
    //MARK:- Gestures
    @objc func taptap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                if let tappedCell = self.tableView.cellForRow(at: tapIndexPath) as? MyFriendsTableViewCell {
                    let animation = CASpringAnimation(keyPath: "transform.scale")
                    animation.fromValue = 0.6
                    animation.toValue = 1
                    animation.stiffness = 200
                    animation.mass = 2
                    animation.duration = 0.8
                    tappedCell.customAvatarView.layer.add(animation, forKey: nil)
                    
                }
            }
        }
    }
}

//MARK:- Extensions

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
