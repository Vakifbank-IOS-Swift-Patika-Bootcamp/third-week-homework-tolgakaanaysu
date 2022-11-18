//
//  Employee.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 14.11.2022.
//

import Foundation

//MARK: - EMPLOYEE

//Employee level
enum DeveloperType: CaseIterable {
    case intern
    case junior
    case mid
    case senior
    
    var toString: String {
        switch self {
        case .intern:
            return "Intern"
        case .junior:
            return "Junior"
        case .mid:
            return "Mid"
        case .senior:
            return "Senior"
        }
    }
    
    // Employee salary coefficient
    var coefficient: Int {
        switch self {
        case .intern:
            return 1
        case .junior:
            return 2
        case .mid:
            return 3
        case .senior:
            return 4
        }
    }
}

//Marital status of employee
enum MaritalStatus: CaseIterable {
    case married
    case single
    
    var toString: String {
        switch self {
        case .single:
            return "Single"
        case .married:
            return "Married"
        }
    }
}


extension String {
    func toDeveloperType() -> DeveloperType? {
        switch self {
        case "Intern":
            return .intern
        case "Junior":
            return .junior
        case "Mid":
            return .mid
        case "Senior":
            return .senior
        default:
            return nil
        }
    }
    
    func toMaritalStatus() -> MaritalStatus? {
        switch self {
        case "Married":
            return .married
        case "Single":
            return .single
        default:
            return nil
        }
    
        
    }
}

protocol EmployeeProtocol {
    var name: String { get }
    var age: Int { get }
    var maritalStatus: MaritalStatus { get }
    var developerType: DeveloperType? { get set }
    var salary: Int? { get }
    var company: String? { get set }
    
}

class Employee: EmployeeProtocol {
    var name: String
    var age: Int
    var maritalStatus: MaritalStatus
    var developerType: DeveloperType?
    var company: String? = nil
    var salary: Int? {
        guard let developerType else { return nil }
        return Employee.calculateSalary(age: age, developerType: developerType)
        }

    init(name: String, age: Int, maritalStatus: MaritalStatus) {
        self.name = name
        self.age = age
        self.maritalStatus = maritalStatus
    }
    
    class func calculateSalary(age: Int, developerType: DeveloperType) -> Int {
        return age * developerType.coefficient * 100
    }
    
}
