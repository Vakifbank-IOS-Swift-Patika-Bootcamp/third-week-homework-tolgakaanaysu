//
//  Utility.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 18.11.2022.
//

import Foundation


// convert from integer type to string type
extension String {
    func toInteger() -> Int? {
        guard let integer = Int(self) else { return nil}
        return integer
    }
}

// convert from string type to integer type
extension Int {
    func toString() -> String? {
        return String(self)
    }
}
