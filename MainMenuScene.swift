//
//  MainMenuScene.swift
//  FinalMid
//
//  Created by 小同同 on 4/10/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

let defaultss = UserDefaults.standard

class MainMenuScene: SKScene{
    
    var activeRec: CGRect!
    var start: SystemButtonNode!
    var help: SystemButtonNode!
    var rank: SystemButtonNode!
    let light = SKLightNode()
    
    override func didMove(to view: SKView) {
        
        let size = self.frame.size
        let background = SKSpriteNode(imageNamed: "background")
        background.size = size
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        let nameLabel = SKLabelNode(fontNamed: "Chalkduster")
        nameLabel.text = "Greedy AirPlane"
        nameLabel.fontColor = SKColor.red
        nameLabel.fontSize = 70
        nameLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        nameLabel.zPosition = 1
        self.addChild(nameLabel)
        
        activeRec = CGRect(origin: self.frame.origin, size: CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!))
        start = SystemButtonNode(in: self.activeRec, image: "startButton", size: buttonSize, buttonType: SystemButtonNode.SystemButtonType.start)
        help = SystemButtonNode(in: self.activeRec, image: "helpButton", size: buttonSize, buttonType: SystemButtonNode.SystemButtonType.help)
        rank = SystemButtonNode(in: self.activeRec, image: "rankButton", size: buttonSize, buttonType: SystemButtonNode.SystemButtonType.rank)
        self.addChild(start)
        self.addChild(help)
        self.addChild(rank)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let myTransition = SKTransition.fade(withDuration: 0.5)
            var sceneToMoveTo: SKScene!
            
            if start.contains(pointOfTouch) {
                sceneToMoveTo = StartScene(size: size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
            } else if help.contains(pointOfTouch){
                sceneToMoveTo = HelpScene(size: size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
                
            } else if rank.contains(pointOfTouch){
                sceneToMoveTo = RankView(size: size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}
