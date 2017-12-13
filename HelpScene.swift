//
//  HelpScene.swift
//  FinalMid
//
//  Created by 小同同 on 4/11/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import Foundation
import SpriteKit

class HelpScene: SKScene{
    
    var activeRect: CGRect!
    var mainMenu: SystemButtonNode!
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        let helpLabel = SKLabelNode(fontNamed: "Chalkduster")
        helpLabel.text = "Rules"
        helpLabel.fontColor = SKColor.white
        helpLabel.fontSize = 50
        helpLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.93)
        helpLabel.zPosition = 1
        self.addChild(helpLabel)
        
        let helpLabel1 = SKLabelNode(fontNamed: "Chalkduster")
        helpLabel1.text = "How to control:"
        helpLabel1.fontColor = SKColor.white
        helpLabel1.fontSize = 35
        helpLabel1.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.87)
        helpLabel1.zPosition = 1
        self.addChild(helpLabel1)
        
        let ruleLabel = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel.text = "Use the right and left button to control"
        ruleLabel.fontColor = SKColor.white
        ruleLabel.fontSize = 25
        ruleLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.81)
        ruleLabel.zPosition = 1
        self.addChild(ruleLabel)
        
        let ruleLabel1 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel1.text = "the direction of the aircraft, the longer"
        ruleLabel1.fontColor = SKColor.white
        ruleLabel1.fontSize = 25
        ruleLabel1.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.77)
        ruleLabel1.zPosition = 1
        self.addChild(ruleLabel1)
        
        let ruleLabel2 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel2.text = "you press the button,the larger it rotate."
        ruleLabel2.fontColor = SKColor.white
        ruleLabel2.fontSize = 25
        ruleLabel2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.73)
        ruleLabel2.zPosition = 1
        self.addChild(ruleLabel2)
        
        let ruleLabel3 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel3.text = "How to win:"
        ruleLabel3.fontColor = SKColor.white
        ruleLabel3.fontSize = 35
        ruleLabel3.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.67)
        ruleLabel3.zPosition = 1
        self.addChild(ruleLabel3)
        
        let ruleLabel4 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel4.text = "There is a timer on the top of screen, so"
        ruleLabel4.fontColor = SKColor.white
        ruleLabel4.fontSize = 25
        ruleLabel4.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.61)
        ruleLabel4.zPosition = 1
        self.addChild(ruleLabel4)
        
        let ruleLabel5 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel5.text = "you need to collect all coins within the"
        ruleLabel5.fontColor = SKColor.white
        ruleLabel5.fontSize = 25
        ruleLabel5.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.57)
        ruleLabel5.zPosition = 1
        self.addChild(ruleLabel5)
        
        let ruleLabel6 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel6.text = "assigned time. After you collect all coins"
        ruleLabel6.fontColor = SKColor.white
        ruleLabel6.fontSize = 25
        ruleLabel6.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.53)
        ruleLabel6.zPosition = 1
        self.addChild(ruleLabel6)
        
        let ruleLabel7 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel7.text = "you will enter a harder level after a slot"
        ruleLabel7.fontColor = SKColor.white
        ruleLabel7.fontSize = 25
        ruleLabel7.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.49)
        ruleLabel7.zPosition = 1
        self.addChild(ruleLabel7)
        
        let ruleLabel8 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel8.text = "of 3 seconds. If you want to have a rest, "
        ruleLabel8.fontColor = SKColor.white
        ruleLabel8.fontSize = 25
        ruleLabel8.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.45)
        ruleLabel8.zPosition = 1
        self.addChild(ruleLabel8)
        
        let ruleLabel9 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel9.text = "you can press the pause button on the right"
        ruleLabel9.fontColor = SKColor.white
        ruleLabel9.fontSize = 25
        ruleLabel9.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.41)
        ruleLabel9.zPosition = 1
        self.addChild(ruleLabel9)
        
        let ruleLabel10 = SKLabelNode(fontNamed: "Chalkduster")
        
        ruleLabel10.text = " top of the screen anytime you want. Enjoy"
        ruleLabel10.fontColor = SKColor.white
        ruleLabel10.fontSize = 25
        ruleLabel10.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.37)
        ruleLabel10.zPosition = 1
        self.addChild(ruleLabel10)
        
        //let mainMenuLabel = SKLabelNode(fontNamed: "Roboto-BlackItalic")
        let buttonSize = CGSize(width:300, height:70)
        activeRect = CGRect(origin: self.frame.origin, size: CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!))
        mainMenu = SystemButtonNode(in: self.activeRect, image: "mainButton", size: buttonSize, buttonType: SystemButtonNode.SystemButtonType.mainMenu)
        self.addChild(mainMenu)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let myTransition = SKTransition.fade(withDuration: 0.5)
            var sceneToMoveTo: SKScene
            if mainMenu.contains(pointOfTouch) {
                sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
                self.scene?.view?.reloadInputViews()
            }
        }
    }
    
}
