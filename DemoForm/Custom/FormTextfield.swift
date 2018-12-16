//
//  FormTextfield.swift
//  DemoForm
//
//  Created by nostra on 12/13/18.
//  Copyright © 2018 nostra. All rights reserved.
//

import UIKit

@IBDesignable class FormTextfield: UIView {
    let kCONTENT_XIB_NAME = "FormTextfield"
    
    @IBInspectable var placeholder: String? {
        get {
            return textfield.placeholder
        }
        set(placeholder) {
            textfield.placeholder = placeholder
        }
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetUp()
    }
    
    init(frame: CGRect, placeholder: String) {
        super.init(frame: frame)
        xibSetUp()
        
       textfield.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
    }
    
    func xibSetUp() {
        contentView = loadViewFromNib()
        contentView.frame = self.bounds
        
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func showValidationError() {
        lblError.isHidden = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func hideValidationError() {
        lblError.isHidden = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }

}
