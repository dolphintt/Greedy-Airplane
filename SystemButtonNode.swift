//
//  SystemButtonNode.swift
//  FinalMid
//
//  Created by 小同同 on 4/23/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import Foundation
import SpriteKit
class SystemButtonNode: SKSpriteNode{
    
    enum SystemButtonType {
        case start
        case help
        case rank
        case mainMenu
        case resume
        case restart
    }
    
    private var type: SystemButtonType
    private var superRectangle: CGRect
    let light = SKLightNode()
    //static let category = UInt32(0b00100)
    
    init(in rectangle: CGRect, image: String, size: CGSize, buttonType: SystemButtonType){
        self.superRectangle = rectangle
        self.type = buttonType
        let newTexture = SKTexture(imageNamed: image)
        super.init(texture: newTexture, color: UIColor.clear, size: size)
        let xPos = rectangle.size.width * 0.5
        let yPos = rectangle.size.height
        if buttonType == SystemButtonType.mainMenu{
            self.position = CGPoint(x: xPos, y: yPos * 0.17)
            light.categoryBitMask = mainSceneCategory
            lightingBitMask = mainSceneCategory | mainMenuCategory
        } else if buttonType == .start {
            self.position = CGPoint(x: xPos, y: yPos * 0.37)
            lightingBitMask = mainSceneCategory | startCategory
        } else if buttonType == .rank{
            self.position = CGPoint(x: xPos, y: yPos * 0.17)
            lightingBitMask = mainSceneCategory | rankCategory
        } else if buttonType == .help{
            self.position = CGPoint(x: xPos, y: yPos * 0.27)
            lightingBitMask = mainSceneCategory | helpCategory
        } else if buttonType == .resume{
            self.position = CGPoint(x: xPos, y: yPos * 0.66)
            lightingBitMask = mainSceneCategory | resumeCategory
        } else if buttonType == .restart {
            self.position = CGPoint(x: xPos, y: yPos * 0.37)
            lightingBitMask = mainSceneCategory | restartCategory
        }
        self.zPosition = 1
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: size)
        self.physicsBody?.isDynamic = false
        self.addChild(light)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
