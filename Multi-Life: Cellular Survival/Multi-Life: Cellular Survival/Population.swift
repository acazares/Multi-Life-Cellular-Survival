//
//  Population.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/7/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation

class Population {
    
    var grid:[[Cell]];
    let gridRows:Int = 100;
    let gridColumns:Int = 100;
    
    init() {
        self.grid = [[]];
        self.killCells();
    }
    
    func updatePopulation() {
        var newPopulation = [[Cell]]();
        for (var r = 0; r < self.gridColumns; r++) {
            for (var c = 0; c < self.gridColumns; c++) {
                var neighborsAlive:Int = 0;
                
                var left:Int = max(0, c-1);
                var right:Int = min(c+1, self.gridColumns-1);
                var up:Int = max(0, r-1);
                var down:Int = min(r+1, gridRows-1);
                var neighbors = [Point]();
                
                var topLeftN:Point = Point(x: left, y: up);
                var leftN:Point = Point(x: left, y: r);
                var bottomLeftN:Point = Point(x: left, y: down);
                var upN:Point = Point(x: c, y: up);
                var downN:Point = Point(x: c, y: down);
                var topRightN:Point = Point(x: right, y: up);
                var rightN:Point = Point(x: right, y: r);
                var bottomRightN:Point = Point(x: right, y: down);
                
                var currentCell:Point = Point(x: c, y: r);
                
                if (topLeftN != currentCell) {
                    neighbors.append(topLeftN);
                }
                if (leftN != currentCell) {
                    neighbors.append(leftN);
                }
                if (bottomLeftN != currentCell) {
                    neighbors.append(bottomLeftN);
                }
                if (upN != currentCell) {
                    neighbors.append(upN);
                }
                if (downN != currentCell) {
                    neighbors.append(downN);
                }
                if (topRightN != currentCell) {
                    neighbors.append(topRightN);
                }
                if (rightN != currentCell) {
                    neighbors.append(rightN);
                }
                if (bottomRightN != currentCell) {
                    neighbors.append(bottomRightN);
                }
                
                for neighbor in neighbors {
                    if (self.isCellAlive(neighbor.x, gridColumn: neighbor.y)) {
                        neighborsAlive++;
                    }
                }
                
                if (self.isCellAlive(r, gridColumn: c)) {
                    if (neighborsAlive < 2 || neighborsAlive > 3) {
                        newPopulation[r][c] = DeadCell();
                    }
                    else {
                        newPopulation[r][c] = AliveCell();
                    }
                }
                else {
                    if (neighborsAlive == 3) {
                        newPopulation[r][c] = AliveCell();
                    }
                    else {
                        newPopulation[r][c] = DeadCell();
                    }
                }
            }
        }
        self.grid = newPopulation;
    }
    
    
    func killCells() {
        for (var r = 0; r < self.gridRows; r++) {
            for (var c = 0; c < self.gridColumns; c++) {
                self.killCell(r,gridColumn: c);
            }
        }
    }
    
    func killCell(gridRow:Int, gridColumn:Int) {
        self.grid[gridRow][gridColumn] = DeadCell();
    }
    
    func isCellAlive(gridRow:Int, gridColumn:Int) -> Bool {
        return self.grid[gridRow][gridColumn].isAlive();
    }
    
    func currentAliveCells() -> Array<Point> {
        var aliveCells = [Point]();
        for (var r = 0; r < self.gridRows; r++) {
            for (var c = 0; r < self.gridColumns; r++) {
                if (self.grid[r][c].isAlive()) {
                    aliveCells.append(Point(x: r, y: c));
                }
            }
        }
        return aliveCells;
    }
}