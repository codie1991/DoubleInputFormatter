//
//  ViewController.swift
//  DoubleInputFormatterDemo
//
//  Created by Codie Westphall on 3/11/23.
//

import UIKit
import DoubleInputFormatter

class ViewController: UIViewController {

    /// UITextField as required by componet
    lazy var bodyTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.borderStyle = .roundedRect
        field.font = UIFont.preferredFont(forTextStyle: .body)
        field.textColor = .systemIndigo
        field.textAlignment = .right
        field.backgroundColor = .systemBackground
        
        field.adjustsFontForContentSizeCategory = true
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.keyboardType = .decimalPad
        
        field.inputAccessoryView = numericToolbar
        
        return field
    }()
    
    /// UIToolbar for dismiss functionality
    lazy var numericToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(doneEditing))
        toolbar.items = [spacer, doneButton]
        toolbar.sizeToFit()
        return toolbar
    }()
    
    /// The formatter for our `UITextField`
    lazy var textFieldFormatter: DoubleInputFormatterTextDelegate = {
        // 1. Create a formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        // 2. Create an instance of our InputFormatter
        let textFieldFormatter = DoubleInputFormatterTextDelegate(
            field: bodyTextField
        )
        
        textFieldFormatter.numberFormatter = formatter
        
        return textFieldFormatter
    }()
    
    
    /// prints out our parsed amount in a double format
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 3. Listen for changes to get the real typed value out
        textFieldFormatter.valueForInput = { value in
            self.amountLabel.text = "\(value)"
        }
    }
    
    /// Toolbar action for dimissing keyboard
    @objc private func doneEditing() {
        bodyTextField.resignFirstResponder()
    }
    
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(bodyTextField)
        view.addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            bodyTextField.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            bodyTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            bodyTextField.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor, constant: 40),
            bodyTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            amountLabel.topAnchor.constraint(equalTo: bodyTextField.bottomAnchor, constant: 40),
            amountLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }


}

