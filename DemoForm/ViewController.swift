//
//  ViewController.swift
//  DemoForm
//
//  Created by nostra on 12/13/18.
//  Copyright © 2018 nostra. All rights reserved.
//

import UIKit
import SwiftValidator

class ViewController: BaseViewController {

    var listTextField : [UITextField]?
    var listAllTextField : [UITextField]?
    var vcValidator: Validator = Validator()
    
    @IBOutlet weak var vcScrollView: UIScrollView!
    @IBOutlet weak var vcContentView: UIView!
    @IBOutlet weak var formTextfield1: FormTextfield!
    @IBOutlet weak var formTextfield2: FormTextfield!
    @IBOutlet weak var formTextfield3: FormTextfield!
    @IBOutlet weak var formTextfield4: FormTextfield!
    @IBOutlet weak var formTextfield5: FormTextfield!
    @IBOutlet weak var formTextfield6: FormTextfield!
    @IBOutlet weak var formTextfield7: FormTextfield!
    @IBOutlet weak var formTextfield8: FormTextfield!
    @IBOutlet weak var formTextfield9: FormTextfield!
    @IBOutlet weak var formTextfield10: FormTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        formTextfield3.textfield.keyboardType = .numberPad
        formTextfield4.textfield.keyboardType = .decimalPad
        
        listTextFields = [formTextfield1.textfield, formTextfield2.textfield, formTextfield3.textfield
                        , formTextfield4.textfield, formTextfield5.textfield, formTextfield6.textfield
                        , formTextfield7.textfield, formTextfield8.textfield, formTextfield9.textfield
                        , formTextfield10.textfield]
        listAllTextFields = listTextField
        
        validator = Validator()
        
        validator?.registerField(formTextfield1.textfield, rules: [RequiredRule(), MinLengthRule(length: 5)])
        validator?.registerField(formTextfield2.textfield, rules: [RequiredRule(), MinLengthRule(length: 5)])
    }
    
    func buttonDitekan() {
        validator?.validate(self)
    }
}

extension ViewController: BaseViewControllerDelegate {
    func setVariables(scrollView: inout UIScrollView, contentView: inout UIView) {
        scrollView = vcScrollView
        contentView = vcContentView
    }
    
    
}

extension ViewController: ValidationDelegate {
    func validationSuccessful() {
        //TODO kalau validasi sukses
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        //TODO kalau gagal
    }
    
    
}

