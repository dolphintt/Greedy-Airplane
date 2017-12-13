//
//  CoinNode.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/9/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import SpriteKit
import Foundation

class CoinNode: SKEmitterNode {
    static let category = UInt32(0b00010)
    private var superRectangle: CGRect!
    init(in rectangle: CGRect, by file: String, of initSize: CGSize) {
        self.superRectangle = rectangle
        super.init()
        self.zPosition = 0.5
        self.physicsBody = SKPhysicsBody(circleOfRadius: initSize.width/2)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.categoryBitMask = RandomCoinNode.category
        self.physicsBody?.contactTestBitMask = AirplaneNode.category
        self.physicsBody?.collisionBitMask = RandomCoinNode.category
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    func fromFile(fileNamed: String) -> CoinNode {
//        if let path = Bundle.main.path(forResource: fileNamed, ofType: "sks") {
//            var data = try NSData(contentsOfFile: path, options: .mappedIfSafe)
//            var archiver = NSKeyedUnarchiver(forReadingWithData: data)
//            
//            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKEmitterNode")
//            let p = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as CoinNode
//            archiver.finishDecoding()
//            
//            return p
//        }
//    }
    func randomPermute() {
        self.randomPermute(in: self.superRectangle)
    }
    func randomPermute(in rectangle: CGRect) {
        let coinWidth = self.frame.width
        let xUpperBound = rectangle.maxX - coinWidth/2
        let xLowerBound = rectangle.minX + coinWidth/2
        let xRandom = randomPosition(max: xUpperBound, min: xLowerBound)
        let coinHeight = self.frame.height
        let yUpperBound = rectangle.maxY - coinHeight/2
        let yLowerBound = rectangle.minY + coinHeight/2
        let yRandom = randomPosition(max: yUpperBound, min: yLowerBound)
        self.position = CGPoint(x: xRandom, y: yRandom)
    }
    //make sure there is no coins overlap with any other node on screen
    private func randomPosition(max: CGFloat, min: CGFloat) -> CGFloat {
        let scale = Float(arc4random()) / Float(UINT32_MAX)
        let randomPoint = CGFloat(scale)*(max - min)
        return randomPoint + min
    }
    func isOverlap(with nodes: [SKNode]?) -> Bool {
        if let children = nodes {
            for child in children {
                if self.frame.intersects(child.frame) || self.frame.equalTo(child.frame){
                    if child.frame.size != child.parent?.frame.size{
                        return true
                    }
                }
            }
        }
        return false
    }
    
}
