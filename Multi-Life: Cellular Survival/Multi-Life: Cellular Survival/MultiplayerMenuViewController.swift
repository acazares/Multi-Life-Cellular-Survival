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
    
    var myMatch:GKMatch = GKMatch();
    
    @IBAction func findMatch(sender: UIButton) { // "Find Match" button functionality
        if (GKLocalPlayer.localPlayer().authenticated) { // The user is logged in to GameCenter
            let request = GKMatchRequest(); // Create the match Request
            request.minPlayers = 2;
            request.maxPlayers = 2;
            let mmvc = GKMatchmakerViewController(matchRequest: request); // Create matchmaker view with the request
            mmvc.matchmakerDelegate = self; // Make the view controller the delegate
            self.presentViewController(mmvc, animated: true, completion: nil); // Present the matchmaker view
        }
        else { // User is not logged in to GameCenter
            println("Local player needs to be authenticated before finding a match.")
        }
    }
    
    func matchmakerViewControllerWasCancelled(viewController: GKMatchmakerViewController!) { // User cancelled matchmaking
        self.dismissViewControllerAnimated(true, completion: nil); // Remove matchmaker view
        println("Local player cancelled the matchmaking process.");
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFailWithError error: NSError!) { // Error occurred
        self.dismissViewControllerAnimated(true, completion: nil); // Remove matchmaker view
        println("Matchmaking failed, printing error...");
        println(error); // Print error
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFindMatch match: GKMatch!) { // Match was established
        self.dismissViewControllerAnimated(true, completion: nil); // Remove matchmaker view
        self.myMatch = match;
        println("A match has been established.")
    }
}