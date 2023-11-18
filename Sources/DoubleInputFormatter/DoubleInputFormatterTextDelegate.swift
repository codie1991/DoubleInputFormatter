//
//  DoubleInputFormatterTextDelegate.swift
//
//
//  Created by Codie Westphall on 16/08/23.
//

import UIKit

/// `DoubleInputFormatterTextDelegate` extends the `UITextFieldDelegate` to provide an easy way to manipulate numeric input for `UITextField`.
public class DoubleInputFormatterTextDelegate: NSObject, UITextFieldDelegate {
    
    /// The `UITextField` to read input from and write our formatted string to
    private let field: UITextField
    
    /// Formating object that performs the transformations
    private let formatter = DoubleInputFormatter()
    
    
    /// The number formatter applied to generate the formatted string
    ///
    /// Defaults to a `.currency` number style.
    /// Override to have more control of the formatted string
    public var numberFormatter: NumberFormatter {
        get{ formatter.numberFormatter }
        set{ formatter.numberFormatter = newValue }
    }
    
    /// Register for updates to the value of the textField input converted to
    public var valueForInput: ((Double) -> Void)? {
        get { formatter.valueForInput }
        set { formatter.valueForInput = newValue }
    }
    
    public init(
        field: UITextField
    ) {
        self.field = field
        super.init()
        field.delegate = self
        field.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        formatter.update(field)
    }
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        formatter.detectSymbolOnBackspace(text: textField.text ?? "", newInput: string)
        return true
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        formatter.update(textField)
    }
    
}
