//
//  AppleWatchKeyboard.swift
//  AppleWatchKeyboard
//
//  Created by Nissi Vieira Miranda on 19/07/15.
//  Copyright (c) 2015 Nissi Vieira Miranda. All rights reserved.
//

import WatchKit
import Foundation

class CharactersKeyboard: WKInterfaceController, CharactersCellDelegate
{
    @IBOutlet weak var textMessage: WKInterfaceLabel!
    
    @IBOutlet weak var leftArrowButton: WKInterfaceButton!
    @IBOutlet weak var rightArrowButton: WKInterfaceButton!
    @IBOutlet weak var charactersTable: WKInterfaceTable!
    @IBOutlet weak var charactersTypesButton: WKInterfaceButton!
    
    var capitalLetters : [[String]]!
    var letters : [[String]]!
    var specialCapitalVowels : [[String]]!
    var specialVowels : [[String]]!
    var numbers : [[String]]!
    var specialCapitalLetters : [[String]]!
    var specialLetters : [[String]]!
    var symbols : [[String]]!
    
    var arrayInUse : NSArray!
    var subArrayInUse : NSArray!
    var subArrayInUseIndex : Int = 0
    var buttonIndex : Int = 0
    var characterTypeIndex : Int = 1
    var message : NSMutableString = ""
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var backButtonTitle = "Cancel"
    let maxLenght : Int = 80
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        capitalLetters = [["A", "B", "C", "D"], ["E", "F", "G", "H"], ["I", "J", "K", "L"], ["M", "N", "O", "P"],
                          ["Q", "R", "S", "T"], ["U", "V", "W", "X"], ["Y", "Z"]]
        
        letters = [["a", "b", "c", "d"], ["e", "f", "g", "h"], ["i", "j", "k", "l"], ["m", "n", "o", "p"],
                   ["q", "r", "s", "t"], ["u", "v", "w", "x"], ["y", "z"]]
        
        specialCapitalVowels = [["À", "Á", "Â", "Ä"], ["Æ", "Ã", "Å", "Ā"], ["È", "É", "Ê", "Ë"], ["Ē", "Ė", "Ę", "Ì"],
                                 ["Į", "Ī", "Í", "Ï"], ["Î", "Õ", "Ō", "Ø"], ["Œ", "Ó", "Ò", "Ö"], ["Ô", "Ū", "Ú", "Ù"],
                                 ["Ü", "Û"]]
        
        specialVowels = [["à", "á", "â", "ä"], ["æ", "ã", "å", "ā"], ["è", "é", "ê", "ë"], ["ē", "ė", "ę", "ì"],
                          ["į", "ī", "í", "ï"], ["î", "õ", "ō", "ø"], ["œ", "ó", "ò", "ö"], ["ô", "ū", "ú", "ù"],
                          ["ü", "û"]]
        
        numbers = [["1", "2", "3", "4"], ["5", "6", "7", "8"], ["9", "0"]]
        
        specialCapitalLetters = [["Ÿ", "Ś", "Š", "Ł"], ["Ž", "Ź", "Ż", "Ç"], ["Ć", "Č", "Ń", "Ñ"]]
        
        specialLetters = [["ÿ", "ś", "š", "ß"], ["ł", "ž", "ź", "ż"], ["ç", "ć", "č", "ń"], ["ñ"]]
        
        symbols = [[":", "(", ")", "$"], ["&", "@", ".", ","], ["?", "!", "+", "="], ["%", "'"]]
        
        arrayInUse = capitalLetters
        subArrayInUse = arrayInUse[0] as! [String]
        
        leftArrowButton.setAlpha(0.5)
        leftArrowButton.setEnabled(false)
        
        updateCharactersTable()
    }

    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func willDisappear()
    {
        if backButtonTitle == "Send"
        {
            let msg = message as String
            defaults.setObject(msg, forKey: "textMessage")
            defaults.synchronize()
        }
    }

    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //-----------------------------------------------------------------------------//
    // MARK: IBActions
    //-----------------------------------------------------------------------------//
    
    @IBAction func leftArrowButtonTapped()
    {
        rightArrowButton.setAlpha(1.0)
        rightArrowButton.setEnabled(true)
        
        subArrayInUseIndex--
        subArrayInUse = arrayInUse[subArrayInUseIndex] as! [String]
        
        updateCharactersTable()
        
        if subArrayInUseIndex == 0
        {
            leftArrowButton.setAlpha(0.5)
            leftArrowButton.setEnabled(false)
        }
    }
    
    @IBAction func clearButtonTapped()
    {
        message = ""
        textMessage.setText(message as String)
        
        backButtonTitle = "Cancel"
        self.setTitle(backButtonTitle)
    }
    
    @IBAction func rightArrowButtonTapped()
    {
        leftArrowButton.setAlpha(1.0)
        leftArrowButton.setEnabled(true)
        
        subArrayInUseIndex++
        subArrayInUse = arrayInUse[subArrayInUseIndex] as! [String]
        
        updateCharactersTable()
        
        if subArrayInUseIndex == (arrayInUse.count - 1)
        {
            rightArrowButton.setAlpha(0.5)
            rightArrowButton.setEnabled(false)
        }
    }
    
    @IBAction func charactersTypesButtonTapped()
    {
        if characterTypeIndex == 8
        {
            characterTypeIndex = 1
        }
        else
        {
            characterTypeIndex++
        }
        
        if characterTypeIndex == 1
        {
            subArrayInUseIndex = 0
            resetArrows()
            arrayInUse = capitalLetters
        }
        else if characterTypeIndex == 2
        {
            arrayInUse = letters
        }
        else if characterTypeIndex == 3
        {
            subArrayInUseIndex = 0
            resetArrows()
            arrayInUse = specialCapitalVowels
        }
        else if characterTypeIndex == 4
        {
            arrayInUse = specialVowels
        }
        else if characterTypeIndex == 5
        {
            subArrayInUseIndex = 0
            resetArrows()
            arrayInUse = numbers
        }
        else if characterTypeIndex == 6
        {
            subArrayInUseIndex = 0
            resetArrows()
            arrayInUse = specialCapitalLetters
        }
        else if characterTypeIndex == 7
        {
            arrayInUse = specialLetters
        }
        else if characterTypeIndex == 8
        {
            subArrayInUseIndex = 0
            resetArrows()
            arrayInUse = symbols
        }
        
        let title = arrayInUse[0][0] as? String
        charactersTypesButton.setTitle(title)
        
        subArrayInUse = arrayInUse[subArrayInUseIndex] as! [String]
        updateCharactersTable()
    }
    
    @IBAction func spaceButtonTapped()
    {
        if message.length < maxLenght
        {
            message.appendString(" ")
            textMessage.setText(message as String)
        }
    }
    
    @IBAction func delButtonTapped()
    {
        let range : NSRange = NSMakeRange((message.length - 1), 1)
        message.deleteCharactersInRange(range)
        textMessage.setText(message as String)
        
        if message.length == 0
        {
            backButtonTitle = "Cancel"
            self.setTitle(backButtonTitle)
        }
    }
    
    //-------------------------------------------------------------------------//
    // MARK: Table
    //-------------------------------------------------------------------------//
    
    func updateCharactersTable()
    {
        charactersTable.setNumberOfRows(1, withRowType: "CharactersCell")
        
        let row = charactersTable.rowControllerAtIndex(0) as! CharactersCell
        
        row.buttonTwo.setHidden(false)
        row.buttonThree.setHidden(false)
        row.buttonFour.setHidden(false)
        
        row.buttonOne.setTitle(subArrayInUse[0] as? String)
        if subArrayInUse.count == 2
        {
            row.buttonTwo.setTitle(subArrayInUse[1] as? String)
            row.buttonThree.setHidden(true)
            row.buttonFour.setHidden(true)
        }
        else if subArrayInUse.count == 3
        {
            row.buttonTwo.setTitle(subArrayInUse[1] as? String)
            row.buttonThree.setTitle(subArrayInUse[2] as? String)
            row.buttonFour.setHidden(true)
        }
        else if subArrayInUse.count == 4
        {
            row.buttonTwo.setTitle(subArrayInUse[1] as? String)
            row.buttonThree.setTitle(subArrayInUse[2] as? String)
            row.buttonFour.setTitle(subArrayInUse[3] as? String)
        }
        else
        {
            row.buttonTwo.setHidden(true)
            row.buttonThree.setHidden(true)
            row.buttonFour.setHidden(true)
        }
        
        row.delegate = self
    }
    
    //-----------------------------------------------------------------------------//
    // MARK: CharactersCellDelegate
    //-----------------------------------------------------------------------------//
    
    func buttonOneClicked()
    {
        buttonIndex = 0
        typeInCharacter()
    }
    
    func buttonTwoClicked()
    {
        buttonIndex = 1
        typeInCharacter()
    }
    
    func buttonThreeClicked()
    {
        buttonIndex = 2
        typeInCharacter()
    }
    
    func buttonFourClicked()
    {
        buttonIndex = 3
        typeInCharacter()
    }
    
    //-----------------------------------------------------------------------------//
    // MARK: Auxiliar methods
    //-----------------------------------------------------------------------------//
    
    func resetArrows()
    {
        leftArrowButton.setAlpha(0.5)
        leftArrowButton.setEnabled(false)
        rightArrowButton.setAlpha(1.0)
        rightArrowButton.setEnabled(true)
    }
    
    func typeInCharacter()
    {
        if message.length < maxLenght
        {
            let character = subArrayInUse[buttonIndex] as! String
            message.appendString(character)
            textMessage.setText(message as String)
            
            if message.length > 0
            {
                backButtonTitle = "Send"
                self.setTitle(backButtonTitle)
            }
        }
    }
}
