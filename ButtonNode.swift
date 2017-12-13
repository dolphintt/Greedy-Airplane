//
//  ButtonNode.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/11/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import Foundation
import SpriteKit

class ButtonNode: SKSpriteNode {
    //button type
    enum ButtonType {
        case left
        case right
    }
    private var type: ButtonType!
    private var superRectangle: CGRect
    static let category = UInt32(0b00100)
    
    //    convenience init() {
    //        self.init(in: CGRect(), with: 0, by: "", of: CGSize(), buttonType: ButtonType.left)
    //    }
    
    init(in rectangle: CGRect, offset: CGFloat, image: String, size: CGSize, buttonType: ButtonType) {
        self.superRectangle = rectangle
        self.type = buttonType
        let newTexture = SKTexture(imageNamed: image)
        super.init(texture: newTexture, color: UIColor.white, size: size)
        if buttonType == ButtonType.left {
            self.position = CGPoint(x: rectangle.minX + offset + 2*size.width, y: rectangle.minY + offset + 2*self.size.height)
        }
        else {
            self.position = CGPoint(x: rectangle.maxX - offset - 2*size.width, y: rectangle.minY + offset + 2*self.size.height)
        }
        self.zPosition = 1
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = ButtonNode.category
        self.physicsBody?.contactTestBitMask = ButtonNode.category
        self.physicsBody?.collisionBitMask = ButtonNode.category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func buttonType() -> ButtonType {
        return type
    }
}
