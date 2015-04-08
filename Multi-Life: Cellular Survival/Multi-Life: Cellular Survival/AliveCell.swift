//
//  AliveCell.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/7/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation

class AliveCell: Cell
{
    var state:Bool;
    
    // Constructor
    init()
    {
        self.state = true; // State of AliveCell will always be true
    }
    
    func isAlive() -> Bool
    {
        return self.state; 
    }
}