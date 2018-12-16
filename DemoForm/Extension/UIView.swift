//
//  UIView.swift
//  DemoForm
//
//  Created by nostra on 12/13/18.
//  Copyright © 2018 nostra. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func configureReturnKeyActionInKeyboard(currentTag: Int) {
        if let next = searchNextField(currentTag: currentTag) {
            next.becomeFirstResponder()
        } else {
            self.endEditing(true)
        }
    }
    
    func searchNextField(currentTag: Int) -> UITextField? {
        let nextTag = currentTag + 1
        
        for view in self.subviews {
            if let textField = view as? UITextField {
                if view.tag == nextTag {
                    return textField
                }
            } else {
                let textField = view.searchNextField(currentTag: currentTag)
                if textField != nil {
                    return textField
                }
            }
        }
        return nil
    }
}
