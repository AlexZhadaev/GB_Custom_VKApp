//
//  CustomAvatarView.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 26.08.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

@IBDesignable class CustomAvatarView: UIView {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarShadow: UIView!
    
//    @IBInspectable var shadowColor: UIColor = UIColor.purple {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    @IBInspectable var shadowOpacity: Float = 0.4 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//
//    @IBInspectable var shadowRadius: CGFloat = 3 {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
    
    func configure() {
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height/2
        avatarImage.setNeedsDisplay()
        
        let frame = avatarImage.frame
        avatarShadow.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height)
        avatarShadow.layer.shadowColor = UIColor.purple.cgColor
        avatarShadow.layer.shadowOpacity = 0.4
        avatarShadow.layer.shadowRadius = 3
        avatarShadow.layer.shadowOffset = CGSize(width: 5, height: 5)
        avatarShadow.layer.cornerRadius = avatarShadow.frame.size.height/2
        avatarShadow.setNeedsDisplay()
        
    }
}

