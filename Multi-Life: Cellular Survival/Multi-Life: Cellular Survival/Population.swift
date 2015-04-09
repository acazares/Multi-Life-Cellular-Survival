//
//  Population.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/7/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation

class Population
{
    var grid:[[Cell]]; // Grid of Cell's as a 2D Array
    let gridRows:Int; // "Height"
    let gridColumns:Int; // "Width"
    
    // Constructor
    init()
    {
        self.grid = [[Cell]](); // Set the grid to be empty
        
        for (var c = 0; c < 22; c++)
        {
            self.grid.append([Cell]());
            self.grid[c] = [Cell](count: 32, repeatedValue: DeadCell());
        }

        self.gridRows = grid.count;
        self.gridColumns = grid[0].count;
    }
    
    func updatePopulation() -> Void
    {
        var newPopulation = [[Cell]](); // Grid of Cells that will become the new Population
        
        for (var c = 0; c < 22; c++)
        {
            newPopulation.append([Cell]());
            newPopulation[c] = [Cell](count: 32, repeatedValue: DeadCell());
        }
        
        
        for (var r = 0; r < self.gridRows; r++) { // Traverse the rows
            for (var c = 0; c < self.gridColumns; c++) { // Traverse the columns
                var neighborsAlive:Int = 0; // Number of AliveCell's that are neighbors of the (r,c) Cell
                
                var left:Int = max(0, c-1); // Left column
                var right:Int = min(c+1, self.gridColumns-1); // Right column
                var up:Int = max(0, r-1); // Top row
                var down:Int = min(r+1, gridRows-1); // Bottom row
                
                var neighbors = [Point](); // Array that will hold the locations of the neighbors of the (r,c) Cell
                
                var topLeftN:Point = Point(x: left, y: up); // Top left neighbor
                var leftN:Point = Point(x: left, y: r); // Left neighbor
                var bottomLeftN:Point = Point(x: left, y: down); // Bottom left neighbor
                var upN:Point = Point(x: c, y: up); // Top neighbor
                var downN:Point = Point(x: c, y: down); // Bottom neighbor
                var topRightN:Point = Point(x: right, y: up); // Top right neighbor
                var rightN:Point = Point(x: right, y: r); // Right neighbor
                var bottomRightN:Point = Point(x: right, y: down); // Bottom right neighbor
                
                var currentCell:Point = Point(x: c, y: r); // Location of current (c,r)
                
                /*
                The next 8 "if" statements will make sure all actual neighbors are added to the
                array of neighbors. When a cell is on some edge of the grid, it will not have all
                8 neighbors. When computing neighbors above, if a neighbor does not exist the math
                will make the non-existent neighbor the current (c,r) cell. These Points should
                not be added to the array.
                */
                if (topLeftN != currentCell)
                {
                    neighbors.append(topLeftN);
                }
                if (leftN != currentCell)
                {
                    neighbors.append(leftN);
                }
                if (bottomLeftN != currentCell)
                {
                    neighbors.append(bottomLeftN);
                }
                if (upN != currentCell)
                {
                    neighbors.append(upN);
                }
                if (downN != currentCell)
                {
                    neighbors.append(downN);
                }
                if (topRightN != currentCell)
                {
                    neighbors.append(topRightN);
                }
                if (rightN != currentCell)
                {
                    neighbors.append(rightN);
                }
                if (bottomRightN != currentCell)
                {
                    neighbors.append(bottomRightN);
                }
                
                for neighbor in neighbors
                {
                    if (self.isCellAlive(neighbor.y, gridColumn: neighbor.x)) // Checks to see if a neighbor is alive
                    {
                        neighborsAlive++; // Count the number of AliveCells
                    }
                }
                
                /*
                This "if" statement will determine whether the current (c,r) cell will be
                alive or dead in the next generation
                */
                if (self.isCellAlive(r, gridColumn: c)) { // Cell is alive
                    if (neighborsAlive < 2 || neighborsAlive > 3) { // Has less than 2 or greater than 3 neighbors
                        newPopulation[r][c] = DeadCell(); // Dies
                    }
                    else {
                        newPopulation[r][c] = AliveCell(); // Lives
                    }
                }
                else { // Cell is Dead
                    if (neighborsAlive == 3) { // Has exactly three alive neighbors
                        newPopulation[r][c] = AliveCell(); // Comes back to life
                    }
                    else {
                        newPopulation[r][c] = DeadCell(); // Stays dead
                    }
                }
            }
        }
        self.grid = newPopulation; // Update the grid
    }
    
    /*
    isCellAlive(int,int) -> bool
    
    Returns whether the cell at the location specified in the 
    grid is alive. The first int specifying which row and the
    second which column.
    */
    func isCellAlive(gridRow:Int, gridColumn:Int) -> Bool
    {
        return self.grid[gridRow][gridColumn].isAlive();
    }
    
    /*
    currentAliveCells() -> Array<Point>
    
    Returns the locations of all the AliveCell's in the grid 
    as an Array of Points.
    */
    
    func currentAliveCells() -> Array<Point>
    {
        var aliveCells = [Point](); // Initialize the Array that will hold the AliveCell's
        for (var r = 0; r < self.gridRows; r++) { // Traverse the rows
            for (var c = 0; c < self.gridColumns; c++) { // Traverse the columns
                if (self.grid[r][c].isAlive()) { // Cell at specified location is alive
                    aliveCells.append(Point(x: c, y: r)); // Add it to the array
                }
            }
        }
        return aliveCells; // Return the array containing the Point's of AliveCells
    }
    
    /*
    resurrect(int,int) -> void
    
    This method will set an AliveCell at the specified location. The 
    first int specifying which row and the second which column.
    */
    
    func resurrect(gridRow:Int, gridColumn:Int)
    {
        self.grid[gridRow][gridColumn] = AliveCell();
    }
}



