//
//  NumberPromptDialog.swift
//
//  Created by Gregg Jaskiewicz on 04/01/2018.
//  Copyright © 2018 Gregg Jaskiewicz. All rights reserved.
//
//


import Foundation

final class NumberPromptDialog: NSObject, UITextFieldDelegate {

    fileprivate var alertController: UIAlertController?
    fileprivate var currentValue: Int = 0
    fileprivate var completionBlock: (_: Int, _: Bool)->() = { _, _ in }

    @objc func promptUserForNumber(title: String, completionBlock: @escaping (_: Int, _: Bool)->()) -> UIViewController {

        self.currentValue = 0
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        self.alertController = alertController
        self.completionBlock = completionBlock

        alertController.addTextField(configurationHandler: { [weak self] (textField) in
            textField.keyboardType = .numberPad
            textField.delegate = self
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action) in
            self.completionBlock(0, false)
        }

        alertController.addAction(cancelAction)

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.completionBlock(self.currentValue, true)
        }

        alertController.addAction(okAction)

        return alertController
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0 {
            return true
        }

        if string.trimmingCharacters(in: .decimalDigits).count == 0 {
            return true
        }

        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let value = (textField.text as NSString?)?.integerValue {
            self.currentValue = value
        } else {
            self.currentValue = 0
        }
    }

}

