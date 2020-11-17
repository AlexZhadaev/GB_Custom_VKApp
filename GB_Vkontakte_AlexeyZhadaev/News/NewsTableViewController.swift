//
//  NewsTableViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 31.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class NewsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var news = ["BreakingNews#1", "BreakingNews#2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil),
        forCellReuseIdentifier: "NewsCellXibKey")
        
    }
    
}
     // MARK: - Navigation

extension NewsTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellXibKey", for: indexPath) as! NewsTableViewCell
        cell.newsLabel?.text = "Моя карьера в жюри премии #ЗолотойГлобус продолжается и я рад дебютировать в качестве ведущего подкаста HFPA In Conversation! Скоро, на http://GoldenGlobes.com и цифровых платформах США!"
        cell.authorAvatar?.image = UIImage(named: "avatarNevsky")
        cell.newsAuthor?.text = "Александр Невский"
        cell.newsDate?.text = "06.09.2020"
        return cell
    }
}

extension NewsTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
    }
}

