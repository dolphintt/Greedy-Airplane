//
//  GameScene.swift
//  FinalMid
//
//  Created by 小同同 on 4/10/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import SpriteKit
import GameplayKit

var gameScore = 0
class GameScene: SKScene {
    var timeRemain = 0
    
    enum gameState{
        case preGame
        case inGame
        case afterGame
    }
    var currentGameState = gameState.inGame
    
    override func didMove(to view: SKView) {
        changeScene()
    }
    
    func runGameOver(){
        currentGameState = gameState.afterGame
        self.removeAllActions()
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
    }
    
    func changeScene(){
        let sceneToMoveTo = PlayScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
