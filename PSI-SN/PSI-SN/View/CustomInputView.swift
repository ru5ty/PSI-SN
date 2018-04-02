//
//  CustomInputView.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 02/04/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import UIKit

class CustomInputView: UIView {
    /// Picker cancel button
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    /// Picker done button
    @IBOutlet weak var doneButton: UIBarButtonItem!
    /// Container view
    @IBOutlet weak var containerView: UIView!
    /// Date Picker container view
    @IBOutlet weak var dateView: UIView!
    /// Date picker object
    @IBOutlet weak var datePicker: UIDatePicker!
    /// Picker container view
    @IBOutlet weak var pickerView: UIView!
    /// Picker object
    @IBOutlet weak var picker: UIPickerView!
    
    /// Cancel action delegate
    var cancelTapped: (_ sender: Any) -> Void = {_ in }
    /// Done action delegate
    var doneTapped: (_ sender: Any) -> Void = {_ in }
    
    /**
     View init
     */
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     Init custom view from XIB
     */
    class func instanceFromNIB(inputType: Constants.Enumeration.InputType) -> CustomInputView{
        let view = Bundle.main.loadNibNamed("CustomInputView", owner: self, options: nil)?.first as! CustomInputView
        var frame = view.containerView.frame
        frame.origin.x = 0
        frame.origin.y = 0
        frame.size.width = UIScreen.main.bounds.width
        switch inputType {
        case .Date, .Time:
            view.dateView.frame = frame
            view.datePicker.datePickerMode = inputType == .Date ? .date : .time
            view.containerView.addSubview(view.dateView)
        case .Other:
            view.pickerView.frame = frame
            view.containerView.addSubview(view.pickerView)
//        default:
//            break
        }
        return view
    }
    
    //    MARK: Actions
    /**
     Cancel button action
     */
    @IBAction func cancelAction(_ sender: Any) {
        self.cancelTapped(sender)
    }
    
    /**
     Done button action
     */
    @IBAction func doneAction(_ sender: Any) {
        self.doneTapped(sender)
    }
}
