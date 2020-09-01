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
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableCellKey")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCellKey", for: indexPath) as! NewsTableViewCell
        let newsUnite = news[indexPath.row]
        cell.newsLabel.text = newsUnite
        //Решил сделать через viewController и добавление tableView, как объяснялось в методичке 3 и на прошлой лекции, но тоже произошел затык с возникновением nil. Если не найду решение, заодно со следующей ДЗ переделаю экран новостей заново, через UITableViewController.
        return cell
    }
}

extension NewsTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
    }
}

