//
//  GameMatch.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/14/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation
import GameKit

class GameMatch: GKMatch, GKMatchDelegate {
    
    var world:Population = Population();

    
    func sendPosition(posn:Point) -> Void
    {
        var error:NSError?;
        var msg:Point = posn;
        var packet:NSData = NSData(bytes: &msg, length: sizeof(Point));
        match.sendDataToAllPlayers(packet, withDataMode: GKMatchSendDataMode.Reliable, error: &error);
        if (error != nil) {
            println("An error has occurred while sending data");
        }
        println("Packet has been sent");
    }
    
    func match(match: GKMatch!, didReceiveData data: NSData!, fromPlayer playerID: String!) {
        let packet = UnsafePointer<Point>(data.bytes).memory;
        world.resurrect(packet.x, gridRow: packet.y);
        println("Packet has been received");
    }
    
    func match(match: GKMatch!, didReceiveData data: NSData!, fromRemotePlayer player: GKPlayer!) {
        let packet = UnsafePointer<Point>(data.bytes).memory;
        world.resurrect(packet.x, gridRow: packet.y);
        println("Packet has been received");
    }
}