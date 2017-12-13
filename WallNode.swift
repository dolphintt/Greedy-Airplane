//
//  WallNode.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/11/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import SpriteKit

class WallNode: SKSpriteNode {
    static let category = UInt32(0b011)
    init(in rectangle: CGRect, of color: UIColor) {
        super.init(texture: SKTexture.init(imageNamed: "wall"), color: color, size: rectangle.size)
        self.position = rectangle.origin
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: rectangle.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = UInt32(0b011)
        self.physicsBody?.contactTestBitMask = AirplaneNode.category
        self.physicsBody?.collisionBitMask = UInt32(0b101010)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
