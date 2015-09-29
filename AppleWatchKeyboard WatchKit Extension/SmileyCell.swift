//
//  SmileyCell.swift
//  AppleWatchKeyboard
//
//  Created by Nissi Vieira Miranda on 9/28/15.
//  Copyright © 2015 Nissi Vieira Miranda. All rights reserved.
//

import UIKit
import WatchKit

protocol SmileyCellDelegate
{
    func smileyOneClicked(rowIdx : Int)
    func smileyTwoClicked(rowIdx : Int)
}

class SmileyCell: NSObject
{
    @IBOutlet weak var smileyOne: WKInterfaceButton!
    @IBOutlet weak var smileyTwo: WKInterfaceButton!
    
    var delegate: SmileyCellDelegate?
    var rowIndex : Int = 0
    
    @IBAction func smileyOneTapped()
    {
        if delegate != nil
        {
            delegate!.smileyOneClicked(rowIndex)
        }
    }
    
    @IBAction func smileyTwoTapped()
    {
        if delegate != nil
        {
            delegate!.smileyTwoClicked(rowIndex)
        }
    }
}
