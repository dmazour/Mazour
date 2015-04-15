//
//  ViewController.swift
//  Mazour
//
//  Created by Labuser on 4/14/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var placeManager: GMBLPlaceManger!
    var commManager: GMBLCommunicationManager!
    
    protocol GMBLPlaceManagerDelegate{
        var placeManager:didBeginVisit
        var placeManager:didReceiveBeaconSighting:forVisits:
        placeMnager:didEndVisit:
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        placeManager = GMBLPlaceManager()
        commManager = GMBLCommunicationManager()
        placeManager.delegate = self
        commManager.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func placeManager(manager: GMBLPlaceManager, didBeginVisit visit: GMBLVisit) {
        println("didBeginVisit: \(visit.place.name), at: \(visit.arrivalDate)")
        
        let atts = visit.place.attributes as GMBLAttributes
        let attKeys = atts.allKeys()
        
        for attKey in attKeys {
            println("\(attKey): \(atts.stringForKey(attKey as String))")
        }
    }
    
    func placeManager(manager: GMBLPlaceManager, didEndVisit visit: GMBLVisit) {
        println("didEndVisit: \(visit.place.name), at: \(visit.departureDate)")
    }
    
    func communicationManager(manager: GMBLCommunicationManager, tableView communications: [AnyObject]!, forVisit visit: GMBLVisit!) ->[AnyObject]!{
        
        if communications is [GMBLCommunication] {
            for comm in communications{
                println("comm title: \(comm.title), descrip: \(comm.descriptionText)")
                providers.append(visit.place.name)
                providers.append(" was here from ")
                providers.append(visit.arrivalDate)
                providers.append(" to ")
                providers.append(visit.departureDate)
            }
        }
        return communications
//        reloadData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func placeManager(manager: GMBLPlaceManager, didBeginVisit visit: GMBLVisit) {
        // this will be invoked when a place is entered
    }
    
    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    var providers: [String] = ["Welcome!"]
    // if(beacon){
    //      providers.append(visit.place.name + " was here from "+ visit.arrivalDate + " to " + visit.departureDate)
    //      reloadData      }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = providers[row]
        
        return cell
    }

}

