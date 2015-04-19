//
//  GameScene.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 3/28/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import SpriteKit
import GameKit

class GameScene: SKScene
{
    var game:GameMatch = GameMatch();
    let pixelSize:CGFloat = 32.0;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        game.setMatchDelegate();
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self);
            let point = convertPixelsToPoint(location);
            game.sendPosition(point);
            game.world.resurrect(point.x, gridRow: point.y);
            drawCell(point);
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
            game.world.updatePopulation();
            removeAllChildren();
            drawCells();
        
        }
    }
    
    func convertPointToPixels(point:Point) -> CGPoint
    {
        return CGPointMake((CGFloat(point.x) * pixelSize), (CGFloat(point.y) * pixelSize));
    }
    
    func convertPixelsToPoint(pixel:CGPoint) -> Point
    {
        return Point(x: Int(pixel.x / pixelSize), y: Int(pixel.y / pixelSize));
    }
    
    
    func drawCells() -> Void
    {
        for cell in game.world.currentAliveCells()
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
        addChild(sprite);
        return sprite;
    }
}
