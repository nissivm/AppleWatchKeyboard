//
//  CharactersCell.swift
//  AppleWatchKeyboard
//
//  Created by Nissi Vieira Miranda on 19/07/15.
//  Copyright (c) 2015 Nissi Vieira Miranda. All rights reserved.
//

import UIKit
import WatchKit

protocol CharactersCellDelegate
{
    func buttonOneClicked()
    func buttonTwoClicked()
    func buttonThreeClicked()
    func buttonFourClicked()
}

class CharactersCell: NSObject
{
    @IBOutlet weak var buttonOne: WKInterfaceButton!
    @IBOutlet weak var buttonTwo: WKInterfaceButton!
    @IBOutlet weak var buttonThree: WKInterfaceButton!
    @IBOutlet weak var buttonFour: WKInterfaceButton!
    
    var delegate: CharactersCellDelegate?
    
    @IBAction func buttonOneTapped()
    {
        if delegate != nil
        {
            delegate!.buttonOneClicked()
        }
    }
    
    @IBAction func buttonTwoTapped()
    {
        if delegate != nil
        {
            delegate!.buttonTwoClicked()
        }
    }
    
    @IBAction func buttonThreeTapped()
    {
        if delegate != nil
        {
            delegate!.buttonThreeClicked()
        }
    }
    
    @IBAction func buttonFourTapped()
    {
        if delegate != nil
        {
            delegate!.buttonFourClicked()
        }
    }
}