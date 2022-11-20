//
//  EmployeeListCell.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 15.11.2022.
//

import UIKit

final class EmployeeListCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var maritalStatusLabel: UILabel!
    @IBOutlet private weak var developerTypeLabel: UILabel!
    @IBOutlet private weak var salaryLabel: UILabel!
    
    func configure(model employee: EmployeeProtocol){
        nameLabel.text = employee.name
        ageLabel.text = String(employee.age)
        maritalStatusLabel.text = employee.maritalStatus.toString
        developerTypeLabel.text = employee.developerType?.toString
        salaryLabel.text = String(employee.salary!)
    }
}
