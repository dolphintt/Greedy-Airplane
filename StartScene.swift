//
//  StartScene.swift
//  FinalMid
//
//  Created by 小同同 on 4/10/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import Foundation
import SpriteKit

class StartScene: SKScene {
    var nameField = UITextField()
    let startLabel = SKLabelNode(fontNamed: "Roboto-BlackItalic")
    var arrayOfUsers = [String]()
    var informLabel = SKLabelNode(fontNamed: "Roboto-BlackItalic")
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.frame.size
        background.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        let nameLabel = SKLabelNode(fontNamed: "Chalkduster")
        nameLabel.text = "Greedy AirPlane"
        nameLabel.fontColor = SKColor.red
        nameLabel.fontSize = 70
        nameLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        nameLabel.zPosition = 1
        self.addChild(nameLabel)
        
        
        informLabel.text = "Input your name"
        informLabel.fontColor = SKColor.white
        informLabel.fontSize = 60
        informLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height * 0.55)
        informLabel.zPosition = 1
        self.addChild(informLabel)
        
        nameField.frame = CGRect(x: 90, y: 400, width: 200, height: 50)
        nameField.borderStyle = UITextBorderStyle.roundedRect
        nameField.backgroundColor = UIColor.gray
        nameField.isHidden = false
        nameField.textColor = UIColor.black
        nameField.alpha = 0.8
        self.view?.addSubview(nameField)
        
        startLabel.text = "Let's Play"
        startLabel.fontSize = 50
        startLabel.fontColor = SKColor.white
        startLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.17)
        startLabel.zPosition = 1
        self.addChild(startLabel)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    func dismissKeyboard() {
        view?.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let myTransition = SKTransition.fade(withDuration: 0.5)
            var sceneToMoveTo: SKScene
            
            if startLabel.contains(pointOfTouch) {
                if (nameField.text?.isEmpty)! {
                    informLabel.text = "Input a valid name"
                    informLabel.fontColor = SKColor.orange
                } else {
                    nameField.removeFromSuperview()
                    
                    let name = "\(nameField.text!)"
                    defaultss.set(name, forKey:"username")
                    
                    sceneToMoveTo = PlayScene(size: size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.view?.presentScene(sceneToMoveTo, transition: myTransition)
                    
                }
            }
        }
    }
}
