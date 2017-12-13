//
//  AirplaneNode.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/9/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import Foundation
import SpriteKit

class AirplaneNode: SKSpriteNode {
    var defaultVelocity = CGFloat(80)
    private var superRectangle: CGRect!
    static let category = UInt32(0b00001)
    private let tail = SKEmitterNode(fileNamed: "RocketTail")
    var isValid: Bool! = true
    init(in rectangle: CGRect, by image: String, of initSize: CGSize) {
        self.superRectangle = rectangle
        let center = CGPoint(x: rectangle.midX, y: rectangle.midY)
        let newTexture = SKTexture(imageNamed: image)
        super.init(texture: newTexture, color: UIColor.white, size: initSize)
        self.zPosition = 0.6
        self.position = center
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: initSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.categoryBitMask = AirplaneNode.category
        self.physicsBody?.contactTestBitMask = RandomCoinNode.category
        self.physicsBody?.collisionBitMask = AirplaneNode.category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //reset airplane to center and reset the angle to zero
    func reset() {
        let center = CGPoint(x: superRectangle.midX, y: superRectangle.midY)
        self.position = center
        self.zRotation = 0
    }
    //move along its direction
    func stepForward() {
        if self.frame.intersects(self.superRectangle){
            turnAround()
        }
        let currentAngle = zRotation(withOffsetAngle: 90)
        self.physicsBody?.velocity = CGVector(angle: currentAngle)*defaultVelocity
        self.tail?.emissionAngle = self.zRotation - CGFloat.pi/2
    }
    //turn left
    func rotateCounterClockwise() {
        let diffRadian = radian(ofAngle: 2)
        self.zRotation += diffRadian
    }
    //turn right
    func rotateClockwise() {
        let diffRadian = radian(ofAngle: -2)
        self.zRotation += diffRadian
    }
    //convert angle to radian
    private func radian(ofAngle angle: CGFloat) -> CGFloat {
        return angle/180*CGFloat.pi
    }
    //
    private func zRotation(withOffsetAngle angle: CGFloat) -> CGFloat {
        let currentRadian = self.zRotation
        let offset = radian(ofAngle: angle)
        return currentRadian + offset
    }
    func turnAround() {
        let len = self.frame.width
        let bottomBound = self.superRectangle.minY + len/2
        let leftBound = self.superRectangle.minX + len/2
        let rightBound = self.superRectangle.maxX - len/2
        let topBound = self.superRectangle.maxY - len/2
        if self.position.x <= leftBound {
            if (self.physicsBody?.velocity.innerProduct(self.superRectangle.leftNormalVector()))! < CGFloat(0) {
                self.zRotation = -self.zRotation
            }
        }
        else if self.position.x >= rightBound {
            if (self.physicsBody?.velocity.innerProduct(self.superRectangle.rightNormalVector()))! < CGFloat(0) {
                self.zRotation = -self.zRotation
            }
        }
        if self.position.y <= bottomBound {
            if (self.physicsBody?.velocity.innerProduct(self.superRectangle.bottomNormalVector()))! < CGFloat(0) {
                self.zRotation = CGFloat.pi - self.zRotation
            }
        }
        else if self.position.y >= topBound {
            if (self.physicsBody?.velocity.innerProduct(self.superRectangle.topNormalVector()))! < CGFloat(0) {
                self.zRotation = CGFloat.pi - self.zRotation
            }
        }
    }
    func speedUp(velocity: CGFloat) {
        self.defaultVelocity += velocity
    }
    //tail effect
    func addTail() {
        self.tail?.particleScale = 0.2
        let tailLocation = CGPoint(x: 0, y: -self.frame.height/2)
        self.tail?.position = tailLocation
        self.tail?.targetNode = self.parent!
        self.tail?.particlePositionRange = CGVector(dx: 6, dy: 0)
        self.tail?.particleSpeed = 80
        self.tail?.particleSpeedRange = 40
        self.tail?.emissionAngle = self.radian(ofAngle: 270)
        self.tail?.particleScaleRange = 0
        self.tail?.particleScaleSpeed = -0.5
        self.tail?.particleSpeed = 50
        self.tail?.particleLifetime = 1
        self.addChild(self.tail!)
    }
}
