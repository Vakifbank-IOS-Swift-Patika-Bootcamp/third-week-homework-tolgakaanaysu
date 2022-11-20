//
//  CompanyManager.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 14.11.2022.
//

import Foundation

//MARK: - Company
protocol CompanyProtocol {
    var name: String  { get }
    var foundationYear: Int { get }
    var addres: String? { get }
    
}

protocol CompanyAccountingManager: CompanyProtocol {
    var employees: [EmployeeProtocol] { get set }
    var balance: Int { get set }
    var totalSalary: Int { get }
    
    // Add employee to company
     func addEmployeeToCompany(_ employee: Employee, developerType: DeveloperType)
    
    // Add money to company account
     func addToBalance(at amount : Int)
    
    // Withdraw money from company account
     func withdrawFromBalance(at amount: Int)
    
    // Pay employees's salary
     func paySalaries()
    
    // Total salary pay to employees
    func getTotalSalary() -> Int
}

extension Company: CompanyAccountingManager {
    
     func addEmployeeToCompany(_ employee: Employee, developerType: DeveloperType) {
        employees.append(employee)
        let addedEmployee = employee
        addedEmployee.developerType = developerType
        addedEmployee.company = self.name
        print("\(employee.name) şirkette \(developerType) olarak  çalışmaya başladı.. Maaşı: \(employee.salary!)₺")
    }
    
    func  getTotalSalary() -> Int {
        var total = 0
        for employee in employees {
            total += employee.salary!
        }
        return total
    }
    
     func paySalaries(){
        if totalSalary < balance {
            balance -= totalSalary
            print("Maaşlar ödendi... Kalan para: \(balance)₺")
        } else {
            print("Bütçe yetersiz.. Maaşlar ödenemedi")
        }
    }
    
     func addToBalance(at amount : Int) {
        guard amount > 100 else {
            print("Lütfen 100₺'den büyük bir miktar giriniz")
            return
        }
        
        balance += amount
        print("Bütçeye \(amount)₺ eklendi. Yeni bütçe: \(balance)₺ ")
    }
    
     func withdrawFromBalance(at amount: Int){
        guard amount > 50 else {
            print("Lütfen 50₺'den büyük bir miktar giriniz")
            return
        }
        guard amount < balance else {
            print("Yetersiz bakiye..")
            return
        }
        
        balance -= amount
        print("Bütçe \(amount)₺ azaldı")
    }
}
