//
//  UITextField.swift
//  DemoForm
//
//  Created by nostra on 12/13/18.
//  Copyright © 2018 nostra. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func configureReturnKeyText(view: UIView, currentTag: Int) {
        if view.searchNextField(currentTag: currentTag+1) != nil {
            self.returnKeyType = .next
        } else {
            self.returnKeyType = .done
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var items: [UIBarButtonItem] = []
        
        if self.superview?.superview?.superview?.superview?.searchNextField(currentTag: self.tag) != nil {
            let next: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(self.nextButtonAction))
            items = [flexSpace, next]
        } else {
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
            items = [flexSpace, done]
        }
        toolbar.items = items
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    
    @objc func nextButtonAction() {
        let nextTextfield = self.superview?.superview?.superview?.superview?.searchNextField(currentTag: self.tag)
        nextTextfield?.becomeFirstResponder()
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
    func showValidationError() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func hideValidationError() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}
