//
//  FindGroupsCell.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 05.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class FindGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageGroup.layer.cornerRadius = imageGroup.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for model: Group) {
        groupName.text = model.name
        imageGroup.load(url: URL(string: model.avatar!)!)
    }
}
