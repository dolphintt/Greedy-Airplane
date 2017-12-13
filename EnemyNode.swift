//
//  EnemyNode.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/19/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyNode: SKSpriteNode {
    var defaultVelocity = CGFloat(40)
    private var superRectangle: CGRect!
    var isValid: Bool! = true
    static let category = UInt32(0b01000)
    init(in rectangle: CGRect, by image: String, of initSize: CGSize) {
        self.superRectangle = rectangle
        let newTexture = SKTexture(imageNamed: image)
        let scaleFactor = initSize.width / newTexture.size().width * 1.4
        let actualSize = newTexture.size().applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
        super.init(texture: newTexture, color: UIColor.white, size: actualSize)
        self.zPosition = 0.4
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.position = CGPoint(x: superRectangle.midX, y: superRectangle.minY - self.frame.height)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: initSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.categoryBitMask = EnemyNode.category
        self.physicsBody?.contactTestBitMask = AirplaneNode.category
        self.physicsBody?.collisionBitMask = EnemyNode.category
    }
    func reset(relateTo point: CGPoint) {
        if point.equalTo(CGPoint(x: superRectangle.midX, y: superRectangle.midY)) {
            self.position = CGPoint(x: superRectangle.midX, y: superRectangle.minY - self.frame.height)
        }
        else if let section = self.validSection(point: point) {
            switch section {
            case 1:
                self.position = CGPoint(x: superRectangle.minX, y: superRectangle.midY/2)
            case 2:
                self.position = CGPoint(x: superRectangle.maxX, y: superRectangle.midY/2)
            case 3:
                self.position = CGPoint(x: superRectangle.maxX, y: 0.75*superRectangle.height)
            case 4:
                self.position = CGPoint(x: superRectangle.minX, y: 0.75*superRectangle.height)
            default:
                self.position = CGPoint(x: superRectangle.midX, y: superRectangle.minY - self.frame.height)
            }
        }
        else { print("Invalid section code!") }
        let v = self.velocity(targetPosition: point)
        self.zRotation = v.angle - CGFloat.pi/2
    }
    private func validSection(point: CGPoint) -> Int? {
        //        if let subRect = subRect(superRect: superRectangle, section: 1) {
        //            if subRect.contains(point) { return 3 }
        //        }
        //        else if let subRect = subRect(superRect: superRectangle, section: 2) {
        //            if subRect.contains(point) { return 4 }
        //        }
        //        else if let subRect = subRect(superRect: superRectangle, section: 3) {
        //            if subRect.contains(point) { return 1 }
        //        }
        //        else if let subRect = subRect(superRect: superRectangle, section: 4) {
        //            if subRect.contains(point) { return 2 }
        //        }
        for (i, j) in zip([1,2,3,4], [3,4,1,2]) {
            if let subRect = subRect(superRect: superRectangle, section: i) {
                if subRect.contains(point) { return j }
            }
        }
        return nil
    }
    private func subRect(superRect: CGRect!, section: Int) -> CGRect? {
        let SRSize = CGSize(width: superRect.width/2, height: superRect.height/2)
        var SROrigin: CGPoint!
        switch section {
        case 1:
            SROrigin = CGPoint(x: superRect.midX, y: superRect.midY)
        case 2:
            SROrigin = CGPoint(x: superRect.minX, y: superRect.midY)
        case 3:
            SROrigin = CGPoint(x: superRect.minX, y: superRect.minY)
        case 4:
            SROrigin = CGPoint(x: superRect.midX, y: superRect.minY)
        default:
            return nil
        }
        return CGRect(origin: SROrigin, size: SRSize)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func speed(targetSpeed: CGFloat) {
        defaultVelocity = targetSpeed/2
    }
    private func velocity(targetPosition: CGPoint) -> CGVector {
        let myPosition = self.position
        let diffY = targetPosition.y - myPosition.y
        let diffX = targetPosition.x - myPosition.x
        let scale = defaultVelocity/self.distance(a: targetPosition, b: myPosition)
        return CGVector(dx: diffX*scale, dy: diffY*scale)
    }
    private func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
    func stepTo(target: CGPoint) {
        let v = self.velocity(targetPosition: target)
        //        self.zRotation = v.angle - CGFloat.pi/2
        self.physicsBody?.velocity = v
    }
    //convert angle to radian
    private func radian(ofAngle angle: CGFloat) -> CGFloat {
        return angle/180*CGFloat.pi
    }
}
