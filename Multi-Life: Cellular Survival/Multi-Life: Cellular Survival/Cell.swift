//
//  Cell.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/7/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation

protocol Cell
{
    /*
    isAlive() -> Bool
    
    This method will simply return the state of the cell. If it's an alive cell
    it will return true and if it's a dead cell it will return false.
    */
    func isAlive() -> Bool;
}
