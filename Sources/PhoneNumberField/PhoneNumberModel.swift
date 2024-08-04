//
//  PhoneNumberModel.swift
//
//
//  Created by Ruslan Kuksa on 03.08.2024.
//

import SwiftUI
import Observation

public enum FieldStyle {
    case plain
    case rounded
}

@Observable
final class PhoneNumberModel {
    
    var text = ""
    
    private(set) var prefix = ""
    private(set) var format = ""
    private(set) var showPrefix = true
    private(set) var roundBorderedStyleColor = Color.primary
    private(set) var fieldStyle: FieldStyle = .plain
    private(set) var placeholder = ""
    
    init() {
        setup()
    }
    
    func handleInput(_ input: String) -> String {
        let cleanNumber = input.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var output = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in format where startIndex < endIndex {
            if char == "#" {
                output.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                output.append(char)
            }
        }
        
        return output
    }
    
    private func setup() {
        guard let country = getCurrentCountryInfo() else { return }
        prefix = country.dialCode
        format = country.pattern
    }
    
    private func getCurrentCountryInfo() -> CountryInfo? {
        guard
            let fileURL = Bundle.module.url(forResource: "CountryNumbers", withExtension: "json"),
            let region = Locale.current.region?.identifier,
            let data = try? Data(contentsOf: fileURL)
        else {
            return nil
        }
        
        do {
            let countries = try JSONDecoder().decode([CountryInfo].self, from: data)
            let dictionary = Dictionary(uniqueKeysWithValues: countries.map { ($0.code, $0) })
            return dictionary[region]
        } catch {
            return nil
        }
    }
}

extension PhoneNumberModel {
    
    func togglePrefixPresentation(_ value: Bool) {
        self.showPrefix = value
    }
    
    func setRoundBorderedStyleColor(_ color: Color) {
        self.roundBorderedStyleColor = color
    }
    
    func setStyle(_ style: FieldStyle) {
        self.fieldStyle = style
    }
    
    func setPlaceholder(_ placeholder: String) {
        self.placeholder = placeholder
    }
}
