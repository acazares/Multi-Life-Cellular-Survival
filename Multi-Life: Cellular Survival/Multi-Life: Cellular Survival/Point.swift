//
//  Point.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/7/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation

struct Point: Equatable {
    
    var x:Int = 0;
    var y:Int = 0;
}

func ==(lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y;
}