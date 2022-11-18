//
//  Extensions.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 18.11.2022.
//

import Foundation

extension String {
    func toInteger() -> Int? {
        guard let integer = Int(self) else { return nil}
        return integer
    }
}

extension Int {
    func toString() -> String? {
        return String(self)
    }
}
