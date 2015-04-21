//
//  GameScene.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 3/28/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import SpriteKit
import GameKit

class GameScene: SKScene, GCHelperDelegate
{
    var world:Population = Population();
    let pixelSize:CGFloat = 32.0;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        GCHelper.sharedInstance.delegate = self;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch: AnyObject in touches
        {
            let location = touch.locationInNode(self);
            let point = convertPixelsToPoint(location);
            sendPosition(point);
            world.resurrect(point.x, gridRow: point.y);
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
            world.updatePopulation();
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
    
    func sendPosition(posn:Point) -> Void {
        var error:NSError?;
        var msg:Point = posn;
        var packet:NSData = NSData(bytes: &msg, length: sizeof(Point));
        let success:Bool = GCHelper.match.sendDataToAllPlayers(packet, withDataMode: GKMatchSendDataMode.Reliable, error: &error);
        if (!success) {
            println("An error has occurred while sending data");
            print(error);
        }
        else
        {
            println("Packet has been sent");
        }
    }
    
    func match(match: GKMatch, didReceiveData data: NSData, fromPlayer playerID: String)
    {
        let packet:Point = UnsafePointer<Point>(data.bytes).memory;
        self.world.resurrect(packet.x, gridRow: packet.y);
        self.drawCell(packet);
    }
    
}
