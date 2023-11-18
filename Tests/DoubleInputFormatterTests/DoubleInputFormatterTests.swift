import XCTest
@testable import DoubleInputFormatter

final class DoubleInputFormatterTests: XCTestCase {
    
    // MARK: Test the `amountAsDouble` value given new inputs, over a variety of currencies
    
    func testAmount_whenInputChanges() throws {
        let textField = UITextField()
        let sut = makeSUT()
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 0.01)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 0.11)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 1.11)
    }
    
    func testAmount_whenInputChanges_withCurrencyOnRight() throws {
        let textField = UITextField()
        let sut = makeSUT(numberFormatter: .frFRFormatter)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 0.01)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 0.11)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 1.11)
    }
    
    func testAmount_whenInputChanges_withZeroDecimalCurrency() throws {
        let textField = UITextField()
        let sut = makeSUT(numberFormatter: .jaJPFormatter)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 1)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 11)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(sut.amountAsDouble, 111)
    }
    
    // MARK: Test the Backspace behaviour for Right symbol currencies
    
    func testBackspace_withCurrencyOnRight() throws {
        let textField = UITextField()
        let sut = makeSUT(numberFormatter: .frFRFormatter)
        
        sut.updateWith(textField: textField, newInput: "1")
        sut.updateWith(textField: textField, newInput: "2")
        sut.updateWith(textField: textField, newInput: "3")
        sut.updateWith(textField: textField, newInput: "4")
        sut.updateWith(textField: textField, newInput: "5")
        sut.updateWith(textField: textField, newInput: "0")
        sut.updateWith(textField: textField, newInput: "0")
        
        XCTAssertEqual(sut.amountAsDouble, 12_345.00)
        XCTAssertEqual(textField.text, "12 345,00 €")
        
        sut.updateWith(textField: textField, newInput: "")
        XCTAssertEqual(sut.amountAsDouble, 1_234.50)
        XCTAssertEqual(textField.text, "1 234,50 €")
    }
    
    // MARK: Test the `UITextField.text` value given new inputs, over a variety of currencies
    
    func testTextField_whenInputChanges() throws {
        let textField = UITextField()
        let sut = makeSUT()
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(textField.text, "$0.01")
        
        sut.updateWith(textField: textField, newInput: "2")
        XCTAssertEqual(textField.text, "$0.12")
        
        sut.updateWith(textField: textField, newInput: "3")
        XCTAssertEqual(textField.text, "$1.23")
        
        sut.updateWith(textField: textField, newInput: "4")
        XCTAssertEqual(textField.text, "$12.34")
        
        sut.updateWith(textField: textField, newInput: "0")
        XCTAssertEqual(textField.text, "$123.40")
        
        sut.updateWith(textField: textField, newInput: "0")
        XCTAssertEqual(textField.text, "$1,234.00")
    }
    
    func testTextField_whenInputChanges_withCurrencyOnRight() throws {
        let textField = UITextField()
        let sut = makeSUT(numberFormatter: .frFRFormatter)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(textField.text, "0,01 €")
        
        sut.updateWith(textField: textField, newInput: "2")
        XCTAssertEqual(textField.text, "0,12 €")
        
        sut.updateWith(textField: textField, newInput: "3")
        XCTAssertEqual(textField.text, "1,23 €")
        
        sut.updateWith(textField: textField, newInput: "4")
        XCTAssertEqual(textField.text, "12,34 €")
        
        sut.updateWith(textField: textField, newInput: "0")
        XCTAssertEqual(textField.text, "123,40 €")
        
        sut.updateWith(textField: textField, newInput: "0")
        XCTAssertEqual(textField.text, "1 234,00 €")
    }
    
    func testTextField_whenInputChanges_withZeroDecimalCurrency() throws {
        let textField = UITextField()
        let sut = makeSUT(numberFormatter: .jaJPFormatter)
        
        sut.updateWith(textField: textField, newInput: "1")
        XCTAssertEqual(textField.text, "¥1")
        
        sut.updateWith(textField: textField, newInput: "2")
        XCTAssertEqual(textField.text, "¥12")
        
        sut.updateWith(textField: textField, newInput: "3")
        XCTAssertEqual(textField.text, "¥123")
        
        sut.updateWith(textField: textField, newInput: "4")
        XCTAssertEqual(textField.text, "¥1,234")
        
        sut.updateWith(textField: textField, newInput: "0")
        XCTAssertEqual(textField.text, "¥12,340")
        
        sut.updateWith(textField: textField, newInput: "0")
        XCTAssertEqual(textField.text, "¥123,400")
        
        sut.updateWith(textField: textField, newInput: "0")
        XCTAssertEqual(textField.text, "¥1,234,000")
    }
    
    // MARK: Test the `UITextField.placeholder` value given a variety of currencies & the .textAlignment value
    
    func testPlaceholder_whenTextAlignmentRight() throws {
        let textField = UITextField()
        textField.textAlignment = .right
        let sut = makeSUT()
        
        sut.updateWith(textField: textField, newInput: "")
        XCTAssertEqual(textField.placeholder, "$0.00")
        XCTAssertEqual(textField.text, "")
    }
    
    func testPlaceholder_whenTextAlignmentLeft() throws {
        let textField = UITextField()
        textField.textAlignment = .left
        let sut = makeSUT()
        
        sut.updateWith(textField: textField, newInput: "")
        XCTAssertEqual(textField.text, "$0.00")
        XCTAssertEqual(textField.placeholder, nil)
    }
    
    func testPlaceholder_whenTextAlignmentRight_withZeroDecimalCurrency() throws {
        let textField = UITextField()
        textField.textAlignment = .right
        let sut = makeSUT(numberFormatter: .jaJPFormatter)
        
        sut.updateWith(textField: textField, newInput: "")
        XCTAssertEqual(textField.placeholder, "¥0")
        XCTAssertEqual(textField.text, "")
    }
    
}

// MARK: - Test Helpers

extension DoubleInputFormatterTests {
    
    /// Creates the system under test for this test class, and configures it configured
    /// - Parameter numberFormatter: The specific formatter to be used by the SUT
    ///
    /// - Returns: A configured `DoubleInputFormatter`
    private func makeSUT(
        numberFormatter: NumberFormatter = .enUSFormatter
    ) -> DoubleInputFormatter {
        
        let sut = DoubleInputFormatter()
        sut.numberFormatter = numberFormatter
        
        return sut
    }
    
}

fileprivate extension DoubleInputFormatter {
    
    /// Runs the `DoubleInputFormatter` as if it were driven by the `DoubleInputFormatterTextDelegate`
    ///
    /// - Parameters:
    ///     - textField: The UITextField that should have it's contents formatted
    ///     - newInput: A single char representation that mimicks the input from the keyboard
    ///
    func updateWith(textField: UITextField, newInput: String) {
        
        detectSymbolOnBackspace(text: textField.text ?? "", newInput: newInput)
        
        var text = textField.text ?? ""
        text += newInput
        textField.text = text
        
        update(textField)
        
    }
    
}

fileprivate extension NumberFormatter {
    
    /// "en-US" currency NumberFormatter
    static let enUSFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en-US")
        return formatter
    }()
    
    /// "ja_JP" currency NumberFormatter
    static let jaJPFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }()
    
    /// "fr_FR" currency NumberFormatter
    static let frFRFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter
    }()
    
}
