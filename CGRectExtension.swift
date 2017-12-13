//
//  CGRect+Extensions.swift
//  FinalDemo
//
//  Created by Jizhou Huang on 4/21/17.
//  Copyright © 2017 Jizhou Huang. All rights reserved.
//

import CoreGraphics

public extension CGRect {
    public func topNormalVector() -> CGVector {
        return CGVector(dx: 0, dy: -1)
    }
    public func bottomNormalVector() -> CGVector {
        return CGVector(dx: 0, dy: 1)
    }
    public func leftNormalVector() -> CGVector {
        return CGVector(dx: 1, dy: 0)
    }
    public func rightNormalVector() -> CGVector {
        return CGVector(dx: -1, dy: 0)
    }
}
