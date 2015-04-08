//
//  Point.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/7/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation

struct Point: Equatable // Equatable: allows the == operator to be written
{
    var x:Int = 0;
    var y:Int = 0;
}

// Equality operator for this structure
func ==(lhs: Point, rhs: Point) -> Bool // lhs & rhs are standard variables for each object being compared
{
    return lhs.x == rhs.x && lhs.y == rhs.y;
}