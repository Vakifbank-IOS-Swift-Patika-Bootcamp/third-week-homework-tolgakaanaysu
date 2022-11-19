//
//  Extensions.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 18.11.2022.
//

import Foundation

extension String {
    func toInteger() -> Int? {
        guard let integer = Int(self) else { return nil }
        return integer
    }
}

extension Int {
    func toString() -> String {
        return String(self)
    }
}

extension Array  where Element == AnimalsProtocol {
    private var nameArray: [String] {
        return self.map({$0.name})
    }
    
    func nameCombine() -> String {
        return nameArray.joined(separator: ", ")
    }
    
    
}

/*
extension String {
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement,
                                         options: NSString.CompareOptions.literal, range: nil)
    }
    func removeChar(to char: String) -> String {
        return self.replace(string: char, replacement: "")
    }
}

*/
