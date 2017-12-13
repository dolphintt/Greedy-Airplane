//
//  SmoothPath.swift
//  JizhouHuang-Lab3
//
//  Created by Jizhou Huang on 2/13/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import Foundation
import UIKit

class SmoothPath: UIBezierPath {
    //private
    private var pathPoints: [CGPoint]
    private var prevPoint: CGPoint?
    
    required init?(coder aDecoder: NSCoder) {
        pathPoints = Array<CGPoint>()
        super.init(coder: aDecoder)
    }
    override init() {
        pathPoints = Array<CGPoint>()
        super.init()
    }
    
    func append(_ smoothPath: SmoothPath) {
        self.append(smoothPath.accessibilityPath!)
        self.pathPoints.append(contentsOf: smoothPath.pathPoints)
    }
    //make sure that this method is used prior to addQuadMove method
    override func move(to point: CGPoint) {
        super.move(to: point)
        prevPoint = point
    }
    func addQuadMove(to endPoint: CGPoint) {
        let controlPoint = prevPoint!
        let linkPoint = midPoint(prevPoint: controlPoint, lastPoint: endPoint)
        addQuadCurve(to: linkPoint, controlPoint: controlPoint)
        move(to: linkPoint)
        prevPoint = endPoint
    }
    
    //calculate midpoint
    func midPoint(prevPoint: CGPoint, lastPoint: CGPoint) -> CGPoint {
        let (x1, y1) = (prevPoint.x, prevPoint.y)
        let (x2, y2) = (lastPoint.x, lastPoint.y)
        return CGPoint(x: (x1 + x2)/2, y: (y1 + y2)/2)
    }
    
}
