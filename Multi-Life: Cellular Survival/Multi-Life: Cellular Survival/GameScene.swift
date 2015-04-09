//
//  GameScene.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 3/28/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import SpriteKit

class GameScene: SKScene
{

    let pixelSize:CGFloat = 32.0;
    var world:Population = Population();
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self);
            let point = convertPixelsToPoint(location);
            world.resurrect(point.y, gridColumn: point.x);
            self.drawCell(point);
        }
    }
   
    var lastUpdateTimeInterval:CFTimeInterval?
    var timeSinceLastTick:Double = -10;
    
    override func update(currentTime: CFTimeInterval) { 
        /* Called before each frame is rendered */
        
        if ((lastUpdateTimeInterval) != nil)
        {
            var timeSinceLast = currentTime - self.lastUpdateTimeInterval!;
            timeSinceLastTick += timeSinceLast
        }
        self.lastUpdateTimeInterval = currentTime;
        if (timeSinceLastTick > 1.5)
        {
            timeSinceLastTick = 0;
            world.updatePopulation();
            self.removeAllChildren();
            self.drawCells();
        }
    }
    
    func convertPointToPixels(point:Point) -> CGPoint
    {
        return CGPointMake((CGFloat(point.x) * self.pixelSize), (CGFloat(point.y) * self.pixelSize));
    }
    
    func convertPixelsToPoint(pixel:CGPoint) -> Point
    {
        return Point(x: Int(pixel.x / self.pixelSize), y: Int(pixel.y / self.pixelSize));
    }
    
    
    func drawCells() -> Void
    {
        for cell in world.currentAliveCells()
        {
            drawCell(cell);
        }
    }
    
    func drawCell(point:Point) -> SKSpriteNode
    {
        let sprite:SKSpriteNode = SKSpriteNode();
        sprite.color = UIColor.cyanColor();
        sprite.size = CGSizeMake(pixelSize, pixelSize);
        sprite.position = convertPointToPixels(point);
        self.addChild(sprite);
        return sprite;
    }
}
