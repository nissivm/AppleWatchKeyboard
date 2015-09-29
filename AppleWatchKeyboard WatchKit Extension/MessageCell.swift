//
//  MessageCell.swift
//  AppleWatchKeyboard
//
//  Created by Nissi Vieira Miranda on 9/22/15.
//  Copyright © 2015 Nissi Vieira Miranda. All rights reserved.
//

import UIKit
import WatchKit

class MessageCell: NSObject
{
    @IBOutlet var avatar: WKInterfaceImage!
    
    @IBOutlet var textMessageBubble: WKInterfaceGroup!
    @IBOutlet var textMessage: WKInterfaceLabel!
    
    @IBOutlet var imageMessageBubble: WKInterfaceGroup!
    @IBOutlet var smiley: WKInterfaceImage!
    
    @IBOutlet var dateGroup: WKInterfaceGroup!
    @IBOutlet var date: WKInterfaceLabel!
}
