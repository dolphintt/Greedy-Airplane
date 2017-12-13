//
//  QuickSort.swift
//  FinalMid
//
//  Created by 小同同 on 4/22/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import Foundation
var test = [1,4,7,9,12,3,2,5,8]


func QuickSort(a:[Int], start:Int, end:Int) {
    var array = [Int]()
    array = a
    if start >= end {
        return
    }
    var l = start
    var r = end
    let pivot = array[start + (end - start) / 2]
    while (l <= r){
        while (l <= r && array[l] < pivot){
            l += 1
        }
        while (l <= r && array[r] > pivot){
            r -= 1
        }
        if l <= r{
            let t = array[l]
            array[l] = array[r]
            array[r] = t
            l += 1
            r -= 1
        }
    }
    print(array)
    QuickSort(a: array, start: start, end: r)
    QuickSort(a: array, start: l, end: end)
}
