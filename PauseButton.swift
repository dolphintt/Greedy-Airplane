//
//  PauseButton.swift
//  FinalMid
//
//  Created by 小同同 on 4/22/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import SpriteKit
class PauseButton: SKSpriteNode {
    let light = SKLightNode()
    let buttonSize = CGSize(width: 150, height: 150)
    init(superScene: SKNode?){
        let buttonTexture = SKTexture(imageNamed: "resume")
        let superWidth = superScene?.frame.width
        let myWidth = superWidth!/2
        let scaleFactor = myWidth/buttonTexture.size().width
        super.init(texture: buttonTexture, color: UIColor.clear, size: buttonTexture.size())
        self.size.applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.position = CGPoint(x: (superScene?.frame.midX)!, y: (superScene?.frame.midY)! + 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


