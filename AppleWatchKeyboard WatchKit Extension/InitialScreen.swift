//
//  InitialScreen.swift
//  AppleWatchKeyboard
//
//  Created by Nissi Vieira Miranda on 9/26/15.
//  Copyright © 2015 Nissi Vieira Miranda. All rights reserved.
//

import WatchKit
import Foundation

class InitialScreen: WKInterfaceController
{
    @IBOutlet var table: WKInterfaceTable!
    
    let avatars : [String] = ["Axl", "Nicole", "Simon", "Suzanne", "Vincent"]

    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        fillAvatarsTable()
    }

    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //-------------------------------------------------------------------------//
    // MARK: Table
    //-------------------------------------------------------------------------//
    
    func fillAvatarsTable()
    {
        table.setNumberOfRows(avatars.count, withRowType: "AvatarCell")
        
        for (index, avatarName) in avatars.enumerate()
        {
            let avatarPath = NSBundle.mainBundle().pathForResource(avatarName, ofType: "png")
            let avatar = UIImage(contentsOfFile: avatarPath!)
            
            let row = table.rowControllerAtIndex(index) as! AvatarCell
                row.avatarImage.setImage(avatar)
                row.avatarName.setText(avatarName)
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int)
    {
        let avatarName = avatars[rowIndex]
        self.pushControllerWithName("ChatRoom", context: avatarName)
    }
}
