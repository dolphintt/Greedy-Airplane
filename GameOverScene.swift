//
//  GameOverScene.swift
//  FinalMid
//
//  Created by 小同同 on 4/10/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import Foundation
import SpriteKit

var score = 0
var name = ""
var players = [Player]()
var player = Player(name: name, score: score)
protocol GameOverSceneDelegate {
    func getScore() -> Int
}



class GameOverScene: SKScene{
    
    var myDelegate: GameOverSceneDelegate?
    var currentScore: Int!
    var activeRec: CGRect!
    var restart: SystemButtonNode!
    var mainMenu: SystemButtonNode!
    
    var sortArray = [Player]()
    func QuickSort(a:[Player], start:Int, end:Int) -> [Player]{
        sortArray = a
        if start >= end {
            return sortArray
        }
        var l = start
        var r = end
        let pivot = sortArray[start + (end - start) / 2].score
        while (l <= r){
            while (l <= r && sortArray[l].score < pivot){
                l += 1
            }
            while (l <= r && sortArray[r].score > pivot){
                r -= 1
            }
            if l <= r{
                let t = sortArray[l]
                sortArray[l] = sortArray[r]
                sortArray[r] = t
                l += 1
                r -= 1
            }
        }
        //print(array)
        QuickSort(a: sortArray, start: start, end: r)
        QuickSort(a: sortArray, start: l, end: end)
        return sortArray
    }

    
    override func didMove(to view: SKView) {
        self.currentScore = myDelegate?.getScore()
        name = defaultss.object(forKey: "username") as? String
        var array = [String]()
        var array2 = [Int]()
        
        if(defaultss.array(forKey: "nameArray") != nil) {
            array = defaultss.array(forKey: "nameArray") as! [String]
        }
        
        if(defaultss.array(forKey: "scoreArray") != nil) {
            array2 = defaultss.array(forKey: "scoreArray") as! [Int]
        }
        
        array2.append(currentScore)
        array.append(name!)
        defaultss.set(array, forKey: "nameArray")
        defaultss.set(array2, forKey: "scoreArray")
        var newarray = defaultss.array(forKey: "nameArray") as! [String]
        var newarray2 = defaultss.array(forKey: "scoreArray") as! [Int]
        
        for i in 0...(newarray.count - 1) {
            player.name = newarray[i]
            player.score = newarray2[i]
            players.append(player)
        }
        var sortedPlayers = QuickSort(a: players, start: 0, end: players.count - 1)
        var rankArray = [String]()
       
        
        for j in 0...sortedPlayers.count - 1 {
            let str = "\(sortedPlayers[sortedPlayers.count - 1 - j].name): \(sortedPlayers[sortedPlayers.count - 1 - j].score)"
            rankArray.append(str)
        }
        print(rankArray)
        defaultss.set(rankArray, forKey: "rankArray")
        rankArray.removeAll()
        players.removeAll()
        
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "Roboto-BlackItalic")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 100
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.75)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let nameLabel = SKLabelNode(fontNamed: "Roboto-BlackItalic")
        nameLabel.text = "Hi \(name!)"
        //scoreLabel.text = "Score: \(gameScore)"
        nameLabel.fontSize = 80
        nameLabel.fontColor = SKColor.white
        nameLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.65)
        nameLabel.zPosition = 1
        self.addChild(nameLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "Roboto-BlackItalic")
        scoreLabel.text = "Score: \(currentScore!)"
        //scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 80
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        //you need to save up to 5 name and score
        let buttonSize = CGSize(width:300, height:70)
        activeRec = CGRect(origin: self.frame.origin, size: CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!))
        restart = SystemButtonNode(in: self.activeRec, image: "restartButton", size: buttonSize, buttonType: SystemButtonNode.SystemButtonType.restart)
        mainMenu = SystemButtonNode(in: self.activeRec, image: "mainButton", size: buttonSize, buttonType: SystemButtonNode.SystemButtonType.mainMenu)
        self.addChild(restart)
        self.addChild(mainMenu)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let myTransition = SKTransition.fade(withDuration: 0.5)
            var sceneToMoveTo: SKScene
            if restart.contains(pointOfTouch) {
                score = 0
                sceneToMoveTo = PlayScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
            } else if mainMenu.contains(pointOfTouch){
                score = 0
                name = ""
                sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                self.view?.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}
