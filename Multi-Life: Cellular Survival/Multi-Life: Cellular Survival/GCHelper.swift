//
//  GCHelper.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 4/19/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation
import GameKit

protocol GCHelperDelegate
{
    func match(match: GKMatch, didReceiveData data: NSData, fromPlayer playerID: String)
}

class GCHelper: NSObject, GKMatchmakerViewControllerDelegate, GKMatchDelegate {
    
    var presentingViewController: UIViewController!;
    var match: GKMatch!;
    var delegate: GCHelperDelegate?;
    var authenticated = false;
    
    class var match: GKMatch {
        get {
            return GCHelper.sharedInstance.match;
        }
    }
    
    class var sharedInstance: GCHelper {
        struct Static {
            static let instance = GCHelper();
        }
        return Static.instance;
    }
    
    func authenticateLocalPlayer(viewController:UIViewController)
    {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer();
        localPlayer.authenticateHandler = { (view, error) -> Void in
            if (view != nil)
            {
                viewController.presentViewController(view, animated: true, completion: nil);
            }
            else if (localPlayer.authenticated)
            {
                self.authenticated = true;
            }
            else
            {
                println(error);
            }
        }
    }
    
    func findMatchWithMinPlayers(minPlayers: Int, maxPlayers: Int, viewController: UIViewController)
    {
        match = nil;
        presentingViewController = viewController;
        let request = GKMatchRequest();
        request.minPlayers = minPlayers;
        request.maxPlayers = maxPlayers;
        
        let mmvc = GKMatchmakerViewController(matchRequest: request);
        mmvc.matchmakerDelegate = self;
        
        self.presentingViewController.presentViewController(mmvc, animated: true, completion: nil);
    }
    
    func matchmakerViewControllerWasCancelled(viewController: GKMatchmakerViewController!)
    {
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFailWithError error: NSError!)
    {
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil);
        println("Error finding match: \(error.localizedDescription)");
    }
    
    func matchmakerViewController(viewController: GKMatchmakerViewController!, didFindMatch theMatch: GKMatch!)
    {
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil);
        self.match = theMatch;
        self.match.delegate = self;
    }
    
    func match(theMatch: GKMatch!, didReceiveData data: NSData!, fromPlayer playerID: String!)
    {
        self.delegate?.match(theMatch, didReceiveData: data, fromPlayer: playerID);
    }
}