//
//  KeyboardViewController.swift
//  numberPad
//
//  Created by Paweł Charatonik on 01.02.2015.
//  Copyright (c) 2015 charatonik. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var numberPadView: UIView!
    
    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }
    
    
    func loadInterface()
    {
        var numPadNib = UINib(nibName: "numberPad", bundle: nil)
        
        numberPadView = numPadNib.instantiateWithOwner(self, options: nil)[0] as UIView
        
        view.addSubview(numberPadView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
