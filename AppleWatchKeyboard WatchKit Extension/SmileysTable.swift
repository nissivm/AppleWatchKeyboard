//
//  SmileysTable.swift
//  AppleWatchKeyboard
//
//  Created by Nissi Vieira Miranda on 9/28/15.
//  Copyright © 2015 Nissi Vieira Miranda. All rights reserved.
//

import WatchKit
import Foundation

class SmileysTable: WKInterfaceController, SmileyCellDelegate
{
    @IBOutlet var smileysTable: WKInterfaceTable!
    
    let smileys : [[String]] = [["smiley-1", "smiley-2"], ["smiley-3", "smiley-4"], ["smiley-5", "smiley-6"],
                                ["smiley-7", "smiley-8"], ["smiley-9", "smiley-10"], ["smiley-11", "smiley-12"]]
    var choosenSmileyName : String?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        fillSmileysTable()
    }

    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func willDisappear()
    {
        if choosenSmileyName != nil
        {
            defaults.setObject(choosenSmileyName!, forKey: "imageMessage")
            defaults.synchronize()
        }
    }

    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //-------------------------------------------------------------------------//
    // MARK: Table
    //-------------------------------------------------------------------------//
    
    func fillSmileysTable()
    {
        smileysTable.setNumberOfRows(smileys.count, withRowType: "SmileyCell")
        
        for (index, smileyDuo) in smileys.enumerate()
        {
            let smileyOnePath = NSBundle.mainBundle().pathForResource(smileyDuo[0], ofType: "png")
            let smileyOne = UIImage(contentsOfFile: smileyOnePath!)
            
            let smileyTwoPath = NSBundle.mainBundle().pathForResource(smileyDuo[1], ofType: "png")
            let smileyTwo = UIImage(contentsOfFile: smileyTwoPath!)
            
            let row = smileysTable.rowControllerAtIndex(index) as! SmileyCell
                row.smileyOne.setBackgroundImage(smileyOne)
                row.smileyTwo.setBackgroundImage(smileyTwo)
                row.rowIndex = index
                row.delegate = self
        }
    }
    
    //-------------------------------------------------------------------------//
    // MARK: SmileyCellDelegate
    //-------------------------------------------------------------------------//
    
    func smileyOneClicked(rowIdx : Int)
    {
        choosenSmileyName = smileys[rowIdx][0]
        self.dismissController()
    }
    
    func smileyTwoClicked(rowIdx : Int)
    {
        choosenSmileyName = smileys[rowIdx][1]
        self.dismissController()
    }
}
