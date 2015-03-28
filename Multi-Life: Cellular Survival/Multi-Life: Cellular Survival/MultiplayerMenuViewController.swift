//
//  MultiplayerMenuViewController.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 3/28/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation
import GameKit

class MultiplayerMenuViewController: UIViewController, GKMatchmakerViewControllerDelegate {
    
    @IBAction func findMatch(sender: UIButton) {
        if (GKLocalPlayer.localPlayer().authenticated) {
            let request = GKMatchRequest();
            request.minPlayers = 2;
            request.maxPlayers = 2;
            let mmvc = GKMatchmakerViewController(matchRequest: request);
            mmvc.matchmakerDelegate = self;
            self.presentViewController(mmvc, animated: true, completion: nil);
        }
        else {
            println("Local user needs to be authenticated before finding a match.")
        }
    }
    
    func matchmakerViewControllerWasCancelled(viewController: GKMatchmakerViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil);
        println("Local user cancelled the matchmaking process.");
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFailWithError error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil);
        println("Matchmaking failed, printing error...");
        println(error);
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFindMatch match: GKMatch!) {
        self.dismissViewControllerAnimated(true, completion: nil);
        println("A match has been established.")
    }
}