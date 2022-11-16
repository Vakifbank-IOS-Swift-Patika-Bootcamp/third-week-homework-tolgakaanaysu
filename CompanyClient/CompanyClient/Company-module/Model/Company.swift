//
//  Model.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 14.11.2022.
//

import Foundation


class Company  {
    var name: String
    let foundationYear: Int
    var addres: String?
    var balance: Int
    var employees: [EmployeeProtocol]
    var totalSalary: Int {
        return getTotalSalary()
    }
    
    init(name: String, foundationYear: Int, addres: String?, balance: Int) {
        self.name = name
        self.foundationYear = foundationYear
        self.addres = addres
        self.balance = balance
        self.employees = []
        print("\(self.name) adlı şirket kuruldu.. Şirket bütçesi: \(self.balance)")
       
    }
}

