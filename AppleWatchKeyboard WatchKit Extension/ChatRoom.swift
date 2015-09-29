//
//  ChatRoom.swift
//  AppleWatchKeyboard
//
//  Created by Nissi Vieira Miranda on 9/26/15.
//  Copyright © 2015 Nissi Vieira Miranda. All rights reserved.
//

import WatchKit
import Foundation
import UIKit

class ChatRoom: WKInterfaceController
{
    @IBOutlet var chatTable: WKInterfaceTable!
    @IBOutlet var notice: WKInterfaceLabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var tableData = [NSMutableDictionary]()
    var counter = 0
    var userName = "Mark"
    var friendName = ""
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        friendName = context as! String
    }
    
    override func willActivate()
    {
        if defaults.objectForKey("textMessage") != nil
        {
            let textMessage = defaults.objectForKey("textMessage") as! String
            let dic = NSMutableDictionary()
                dic.setObject(getCurrentDate(), forKey: "date")
                dic.setObject(textMessage, forKey: "textMessage")
            
            if (counter % 2) == 0
            {
                dic.setObject(userName, forKey: "name")
            }
            else
            {
                dic.setObject(friendName, forKey: "name")
            }
            
            tableData.append(dic)
            
            counter++
            
            defaults.removeObjectForKey("textMessage")
            defaults.synchronize()
        }
        else if defaults.objectForKey("imageMessage") != nil
        {
            let imageMessage = defaults.objectForKey("imageMessage") as! String
            let dic = NSMutableDictionary()
                dic.setObject(getCurrentDate(), forKey: "date")
                dic.setObject(imageMessage, forKey: "imageMessage")
            
            if (counter % 2) == 0
            {
                dic.setObject(userName, forKey: "name")
            }
            else
            {
                dic.setObject(friendName, forKey: "name")
            }
            
            tableData.append(dic)
            
            counter++
            
            defaults.removeObjectForKey("imageMessage")
            defaults.synchronize()
        }
        
        if tableData.count > 0
        {
            notice.setHidden(true)
            chatTable.setHidden(false)
            
            populateTable()
        }
        
        super.willActivate()
    }
    
    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func getCurrentDate() -> String
    {
        let todayDate = NSDate()
        let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(todayDate)
    }
    
    //-------------------------------------------------------------------------//
    // MARK: IBAction
    //-------------------------------------------------------------------------//
    
    @IBAction func smileyButtonTapped()
    {
        presentControllerWithName("SmileysTable", context: nil)
    }
    
    @IBAction func textButtonTapped()
    {
        presentControllerWithName("CharactersKeyboard", context: nil)
    }
    
    //-------------------------------------------------------------------------//
    // MARK: Table
    //-------------------------------------------------------------------------//
    
    func populateTable()
    {
        chatTable.setNumberOfRows(tableData.count, withRowType: "MessageCell")
        
        for (index, message) in tableData.enumerate()
        {
            let row = chatTable.rowControllerAtIndex(index) as! MessageCell
            
            let name = message.objectForKey("name") as! String
            let path = NSBundle.mainBundle().pathForResource(name, ofType: "png")
            let image = UIImage(contentsOfFile: path!)
            row.avatar.setImage(image)
            
            let date = message.objectForKey("date") as! String
            row.date.setText(date)
            
            if message.objectForKey("textMessage") != nil
            {
                let msg = message.objectForKey("textMessage") as! String
                
                row.imageMessageBubble.setHidden(true)
                row.textMessageBubble.setHidden(false)
                row.textMessage.setText(msg)
            }
            else
            {
                let imgName = message.objectForKey("imageMessage") as! String
                let bundlePath = NSBundle.mainBundle().pathForResource(imgName, ofType: "png")
                let image = UIImage(contentsOfFile: bundlePath!)
                
                row.textMessageBubble.setHidden(true)
                row.imageMessageBubble.setHidden(false)
                row.smiley.setImage(image)
            }
        }
        
        chatTable.scrollToRowAtIndex(tableData.count - 1)
    }
}
