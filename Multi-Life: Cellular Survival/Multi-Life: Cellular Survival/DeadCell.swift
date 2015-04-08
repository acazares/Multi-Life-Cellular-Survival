//
//  DeadCell.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/7/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation

class DeadCell: Cell {
    
    var state:Bool;
    
    init() {
        self.state = true;
    }
    
    func isAlive() -> Bool {
        return self.state;
    }
}