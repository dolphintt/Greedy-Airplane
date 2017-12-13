//
//  PlayScene.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/5/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import SpriteKit
import Foundation
import AVFoundation

class PlayScene: SKScene, SKPhysicsContactDelegate, GameOverSceneDelegate {
    var activeRect: CGRect!
    var airplane: AirplaneNode!
    var enemy: EnemyNode!
    var countdown: NumericLabel!
    // exploding flag
    var isExploding: Bool! = false
    var score: NumericLabel!
    var soundPlayer = SoundManager()
    var pauseButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var resumeButton: SystemButtonNode!
    var mainMenu: SystemButtonNode!
    var isPausing: Bool! = true
    var bounceTimer: Timer!
    var level = 1
    var levelLabel: SKLabelNode!
    var coinNumber = 9
    var array = [String]()
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        let background = self.background(imageTitle: "background")
        self.addChild(background)
        self.getReady()
    }
    
    func getReady(){
        var timer = 2
        let timerLabel = SKLabelNode(text: "\(timer + 1)")
        timerLabel.fontName = "ChalkboardSE-Regular"
        timerLabel.fontSize = 120
        timerLabel.fontColor = SKColor.white
        timerLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        timerLabel.zPosition = 1
        self.addChild(timerLabel)
        
        let buttonLarge = SKAction.scale(to: 1.25, duration: 0.5)
        let timedown = SKAction.afterDelay(0, runBlock: {
            timer = timer - 1
            timerLabel.text = "\(timer + 1)"
        })
        let buttonNormal = SKAction.scale(to: 1, duration: 0.5)
        let buttonSequence = SKAction.sequence([buttonLarge, timedown, buttonNormal])
        timerLabel.run(SKAction.repeat(buttonSequence, count: 2), completion: {
            timerLabel.removeFromParent()
            self.loadGame()})
        
    }
    
    func loadGame(){
        self.addChild(soundPlayer)
        print("we are here")
        self.soundPlayer.playBGM()
        
        let iconSize = CGSize(width: 80, height: 80)
        let clockIcon = SKSpriteNode(texture: SKTexture.init(imageNamed: "clock"), size: iconSize)
        clockIcon.anchorPoint = CGPoint(x: 0, y: 1)
        clockIcon.position = CGPoint(x: self.frame.minX + 10, y: self.frame.maxY - 10)
        clockIcon.zPosition = 1
        self.addChild(clockIcon)
        //active rectangle
        activeRect = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: clockIcon.frame.minY - 20))
        //add timer
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeUpdate), userInfo: nil, repeats: true)
        //countdown label
        countdown = NumericLabel(number: 45, newFontName: "ChalkboardSE-Regular", newFontSize: 60, newFontColor: UIColor.green)
        countdown.position = CGPoint(x: clockIcon.frame.maxX + countdown.frame.width/2 + 5, y: clockIcon.frame.minY + 5)
        self.addChild(countdown)
        //score indicator
        score = NumericLabel(number: 0, newFontName: "Chalkduster", newFontSize: 60, newFontColor: UIColor.white)
        score.position = CGPoint(x: self.frame.midX, y: clockIcon.frame.minY + 5)
        self.addChild(score)
        //add pause button
        self.pauseButton = SKSpriteNode(imageNamed: "pause")
        self.pauseButton.size = iconSize
        self.pauseButton.anchorPoint = CGPoint(x: 1, y: 1)
        self.pauseButton.position = CGPoint(x: self.frame.maxX - 10, y: self.frame.maxY - 10)
        self.pauseButton.zPosition = 1
        self.addChild(self.pauseButton)
        //initialize buttons
        self.updateLevel()
        
        let buttonSize = CGSize(width: 100, height: 100)
        leftButton = ButtonNode(in: self.activeRect, offset: 5, image: "counterClock", size: buttonSize, buttonType: ButtonNode.ButtonType.left)
        self.addChild(leftButton)
        rightButton = ButtonNode(in: self.activeRect, offset: 5, image: "clockwise", size: buttonSize, buttonType: ButtonNode.ButtonType.right)
        self.addChild(rightButton)
        //initialize airplane
        let airplaneSize = CGSize(width: 40, height: 40)
        airplane = AirplaneNode(in: self.activeRect, by: "Spaceship", of: airplaneSize)
        self.addChild(airplane)
        airplane.addTail()
        enemy = EnemyNode(in: self.activeRect, by: "ufo1", of: airplaneSize)
        
        self.addChild(enemy)
        self.randomDistributeCoins(coinNumber: coinNumber)
        self.isPausing = false
    }
    
    func updateLevel(){
        levelLabel = SKLabelNode(fontNamed: "Chalkduster")
        self.levelLabel.fontSize = 30
        self.levelLabel.fontColor = SKColor.white
        self.levelLabel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 5)
        self.levelLabel.zPosition = 1
        self.levelLabel.text = "level\( level)"
        self.addChild(levelLabel)

    }
    func background(imageTitle: String) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: imageTitle)
        node.size = self.size
        node.anchorPoint = CGPoint(x: 0, y: 0)
        node.position = self.frame.origin
        node.zPosition = 0
        return node
    }
    func randomDistributeCoins(coinNumber: Int) {
        let nodeNumber = self.children.count
        let coinSize = CGSize(width: 40, height: 40)
        while self.children.count < nodeNumber + coinNumber {
            let coin = RandomCoinNode(in: self.activeRect, by: "coin", of: coinSize)
            coin.randomPermute()
            if !coin.isOverlap(with: self.children) {
                self.addChild(coin)
            }
        }
    }
    func pause() {
        self.isPaused = true
    }
    func resume() {
        self.isPaused = false
    }
    func restart() {
        self.isPaused = false
        self.isExploding = false
        self.score.resetScore()
        self.enemy.removeFromParent()
        for child in self.children {
            if child.isKind(of: RandomCoinNode.self) {
                child.removeFromParent()
            }
        }
        self.configTheNext()
    }
    
    func gameOver() {
        self.soundPlayer.stopBGM()
        self.pause()
        /* jump to game over scene */
        self.changeScene()
        
    }
    func timeUpdate() {
        if !self.isPaused {
            if countdown.labelInNumber > 0{
                countdown.updateTime()
            }
            else {
                //time up
                self.gameOver()
            }
        }
    }
    //delegate
    func getScore() -> Int {
        return score.labelInNumber
    }
    //make sure there is no coins overlap with any other node on screen
    func configTheNext() {
        if !self.children.contains(airplane) {
            airplane.reset()
            self.addChild(airplane)
        }
        level += 1
        if level <= 5{
            coinNumber += 5
        } else if level <= 10{
            if !self.children.contains(enemy) {
                self.enemy.reset(relateTo: airplane.position)
                self.addChild(enemy)
            }
        }
        //        if score.labelInNumber >= 50 {
        //            if !self.children.contains(enemy) {
        //                self.enemy.reset(relateTo: airplane.position)
        //                self.addChild(enemy)
        //            }
        //            self.enemy.speed(targetSpeed: airplane.defaultVelocity)
        //        }
        countdown.resetTime(to: 45)
        randomDistributeCoins(coinNumber: coinNumber)
        updateLevel()
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let objA = contact.bodyA
        let objB = contact.bodyB
        if objA.node != nil && objB.node != nil {
            //hit coins
            if objA.categoryBitMask == RandomCoinNode.category && objB.categoryBitMask == AirplaneNode.category {
                self.consume(node: objA.node!)
                objA.node?.removeFromParent()
                self.soundPlayer.crash()
                score.updateScore(with: 1)
            }
            else if objB.categoryBitMask == RandomCoinNode.category && objA.categoryBitMask == AirplaneNode.category {
                self.consume(node: objB.node!)
                objB.node?.removeFromParent()
                self.soundPlayer.crash()
                score.updateScore(with: 1)
            }
                //hit enemy
            else if objA.categoryBitMask == EnemyNode.category || objB.categoryBitMask == EnemyNode.category {
                if !self.isExploding {
                    self.soundPlayer.gameOver()
                    self.explode()
                    self.soundPlayer.stopBGM()
                    print("Game Over")
                }
            }
        }
    }
    //hit enemy
    func explode() {
        self.isExploding = true
        let midX = (self.airplane.position.x + self.enemy.position.x)/2
        let midY = (self.airplane.position.y + self.enemy.position.y)/2
        let emitterNode = SKEmitterNode(fileNamed: "Explosion")
        emitterNode?.particlePosition = CGPoint(x: midX, y: midY)
        self.addChild(emitterNode!)
        // invalidate the objects
        self.run(SKAction.afterDelay(0.25, runBlock: {
            self.airplane.isValid = false
            self.enemy.isValid = false
        }))
        // Don't forget to remove the emitter node after the explosion
        self.run(SKAction.wait(forDuration: 2), completion: {
            emitterNode?.removeFromParent()
            self.isExploding = false
            self.gameOver()})
    }
    //consume coin
    func consume(node: SKNode) {
        let emitterNode = SKEmitterNode(fileNamed: "Consumption")
        emitterNode?.particlePosition = node.position
        self.addChild(emitterNode!)
        // Don't forget to remove the emitter node after the explosion
        self.run(SKAction.wait(forDuration: 2), completion: {emitterNode?.removeFromParent()})
    }
    
    //touch buttons
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if !isPaused && self.nodes(at: location).contains(pauseButton) {
                self.pause()
                self.hideGame()
            }
            if isPaused && self.nodes(at: location).contains(resumeButton){
                self.resume()
                self.showGame()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            for node in self.nodes(at: location) {
                if node.isKind(of: ButtonNode.self) {
                    switch (node as! ButtonNode).buttonType() {
                    case ButtonNode.ButtonType.left:
                        airplane.rotateCounterClockwise()
                    default:
                        airplane.rotateClockwise()
                    }
                }
            }
//            if self.leftButton.frame.contains(location) {
//                airplane.rotateCounterClockwise()
//            }
//            else if self.rightButton.frame.contains(location) {
//                airplane.rotateClockwise()
//            }
        }
    }
    func isThereAnyCoin() -> Bool {
        for child in self.children {
            if child.isKind(of: RandomCoinNode.self) {
                return true
            }
        }
        return false
    }
    override func update(_ currentTime: TimeInterval) {
        if self.isPausing == false {
            airplane.stepForward()
            enemy.stepTo(target: self.airplane.position)
            if !isThereAnyCoin() {
                //configure the next checkpoint
                configTheNext()
            }
            if self.airplane.isValid == false {
                self.airplane.removeFromParent()
                self.airplane.isValid = true
            }
            if self.enemy.isValid == false {
                self.enemy.removeFromParent()
                self.enemy.isValid = true
            }
        }
    }
    
    func changeScene(){
        let sceneToMoveTo = GameOverScene(size: size)
        sceneToMoveTo.myDelegate = self
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func hideGame(){
        for node in self.children{
            node.alpha = 0.5
        }
        self.soundPlayer.pauseBGM()
        let buttonSize = CGSize(width:400, height:100)
        resumeButton = SystemButtonNode(in: self.activeRect, image: "resumeButton", size: buttonSize, buttonType: SystemButtonNode.SystemButtonType.resume)
        addChild(resumeButton)
               
    }
    func showGame(){
        self.resumeButton.removeFromParent()
        for node in self.children{
            node.alpha = 1
        }
        self.soundPlayer.resumeBGM()
    }
}
