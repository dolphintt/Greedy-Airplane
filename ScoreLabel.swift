//
//  ScoreNode.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/9/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreLabel: SKLabelNode {
    var score: Int = 0
    init(number: Int) {
        super.init()
        if number < 10 {
            self.text = "0\(number)"
        }
        else if 10...99 ~= number {
            self.text = "\(number)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        score += 1
        self.text = "\(score)"
    }
    func reset() {
        self.text = "00"
        score = 0
    }
}
