//
//  ScoreNode.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/9/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import Foundation
import SpriteKit

class NumericLabel: SKLabelNode {
    var labelInNumber: Int = 0
    private var defaultColor: UIColor!
    init(number: Int, newFontName: String, newFontSize: CGFloat, newFontColor: UIColor) {
        super.init()
        defaultColor = newFontColor
        self.zPosition = 1
        labelInNumber = number
        self.fontName = "\(newFontName)"
        self.fontSize = newFontSize
        self.fontColor = defaultColor
        if labelInNumber < 10 {
            self.text = "0\(labelInNumber)"
        }
        else if 10...99 ~= labelInNumber {
            self.text = "\(labelInNumber)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateScore(with value: Int) {
        labelInNumber += value
        let scaleUp = SKAction.scale(to: 1.15, duration: 0.03)
        let changeValue = SKAction.afterDelay(0, runBlock: {
            if self.labelInNumber < 10 {
                self.text = "0\(self.labelInNumber)"
            }
            else if 10...99 ~= self.labelInNumber {
                self.text = "\(self.labelInNumber)"
            }
        })
        let scaleDown = SKAction.scale(to: 1, duration: 0.07)
        let getPoints = SKAction.sequence([scaleUp, changeValue, scaleDown])
        self.run(getPoints)
    }
    func updateTime() {
        if self.labelInNumber > 0 {
            labelInNumber -= 1
            if labelInNumber < 10 {
                self.text = "0\(labelInNumber)"
            }
            else if 10...99 ~= labelInNumber {
                self.text = "\(labelInNumber)"
            }
            if labelInNumber < 10 {
                self.fontColor = UIColor.red
                let scaleUp = SKAction.scale(to: 1.3, duration: 0.3)
                let changeValue = SKAction.afterDelay(0, runBlock: {
                    if self.labelInNumber < 10 {
                        self.text = "0\(self.labelInNumber)"
                    }
                    else if 10...99 ~= self.labelInNumber {
                        self.text = "\(self.labelInNumber)"
                    }
                })
                let scaleDown = SKAction.scale(to: 1, duration: 0.3)
                let countDown = SKAction.sequence([scaleUp, changeValue, scaleDown])
                self.run(countDown)
            }
        }
    }
    func resetScore() {
        self.labelInNumber = 0
        self.text = "00"
    }
    func resetTime(to value: Int) {
        self.labelInNumber = value
        self.fontColor = defaultColor
        if labelInNumber < 10 {
            self.text = "0\(labelInNumber)"
        }
        else if 10...99 ~= labelInNumber {
            self.text = "\(labelInNumber)"
        }
    }
}
