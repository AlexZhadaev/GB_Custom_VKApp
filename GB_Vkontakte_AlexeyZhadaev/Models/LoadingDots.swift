//
//  LoadingDots.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 07.09.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

class LoadingDots: UIView {
    
    private let dot = CALayer()
    private let numberOfDots = 3
    private var sizeOfDot = CGRect(x: 0, y: 0, width: 10, height: 10)
    
    @IBInspectable var colorOfDots: UIColor? {
        get {
            return UIColor(cgColor: dot.backgroundColor!)
        } set {
            dot.backgroundColor = newValue?.cgColor
        }
    }
    
    // MARK:- Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDotsLoader()
    }
    
    required init?(coder theCoder: NSCoder) {
        super.init(coder: theCoder)
        createDotsLoader()
    }
    
    private func createDotsLoader() {
        let layerReplicator = CAReplicatorLayer()
        layerReplicator.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        dot.frame = sizeOfDot
        dot.cornerRadius = sizeOfDot.height/2
        
        layerReplicator.addSublayer(dot)
        layerReplicator.instanceCount = numberOfDots
        layerReplicator.instanceTransform = CATransform3DMakeTranslation(24, 0, 0)
        
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 1.0
        animation.toValue = 0.1
        animation.duration = 1
        animation.repeatCount = .infinity
        
        dot.add(animation, forKey: nil)
        layerReplicator.instanceDelay = animation.duration / Double(layerReplicator.instanceCount)
        self.layer.addSublayer(layerReplicator)
    }
    
}
