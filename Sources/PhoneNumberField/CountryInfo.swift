//
//  CountryInfo.swift
//  
//
//  Created by Ruslan Kuksa on 03.08.2024.
//

import Foundation

struct CountriesResults: Decodable {
    var countries: [CountryInfo]
}

struct CountryInfo: Decodable {
    
    var id: String
    var name: String
    var flag: String
    var code: String
    var dialCode: String
    var pattern: String
    var limit: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, flag, code, pattern, limit
        case dialCode = "dial_code"
    }
}
