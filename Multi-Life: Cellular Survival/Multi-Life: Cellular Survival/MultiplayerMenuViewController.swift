//
//  MultiplayerMenuViewController.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 3/28/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation
import GameKit

class MultiplayerMenuViewController: UIViewController {
    
    @IBAction func findMatch(sender: UIButton) { // "Find Match" button functionality
        if (GCHelper.sharedInstance.authenticated) { // The user is logged in to GameCenter
            GCHelper.sharedInstance.findMatchWithMinPlayers(2, maxPlayers: 2, viewController: self);
        }
        else { // User is not logged in to GameCenter
            println("Local player needs to be authenticated before finding a match.")
        }
    }
}