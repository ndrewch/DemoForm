//
//  BaseViewController.swift
//  DemoForm
//
//  Created by nostra on 12/13/18.
//  Copyright © 2018 nostra. All rights reserved.
//

import UIKit
import SwiftValidator

protocol BaseViewControllerDelegate {
    func setVariables(scrollView: inout UIScrollView, contentView: inout UIView)
}

class BaseViewController: UIViewController {

    var currentTag = 0
    var delegate: BaseViewControllerDelegate?
    var listAllTextFields: [UITextField]? = nil
    var listTextFields: [UITextField]? = nil
    var activeField: UITextField? = nil
    var scrollView: UIScrollView = UIScrollView()
    var contentView: UIView = UIView()
    var validator: Validator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delegate?.setVariables(scrollView: &scrollView, contentView: &contentView)
        configureTagsAndDelegates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        deregisterFromKeyboardNotifications()
    }
    
    
    func configureTagsAndDelegates() {
        resetTextFieldTags()
        
        var tag = 0
        listTextFields?.forEach { (textField) in
            textField.tag = tag
            textField.delegate = self
            tag += 1
        }
    }
    
    func resetTextFieldTags() {
        listAllTextFields?.forEach { (textField) in
            textField.tag = 0
        }
    }
    
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
    }
}

extension BaseViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.configureReturnKeyText(view: contentView,currentTag: currentTag)
        
        if textField.keyboardType == .numberPad || textField.keyboardType == .decimalPad {
            textField.doneAccessory = true
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        currentTag = textField.tag
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        contentView.configureReturnKeyActionInKeyboard(currentTag: currentTag)
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        var isFormTextField = false
        
        isFormTextField = textField.superview?.superview?.superview?.isMember(of: FormTextfield.self) ?? false
        validator?.validateField(textField) { error in
            if isFormTextField {
                let formTextField = textField.superview?.superview?.superview as! FormTextfield
                if error == nil {
                    formTextField.hideValidationError()
                } else {
                    formTextField.showValidationError()
                }
            } else {
                if error == nil {
                    textField.hideValidationError()
                } else {
                    textField.showValidationError()
                }
            }
        }
    }
}
