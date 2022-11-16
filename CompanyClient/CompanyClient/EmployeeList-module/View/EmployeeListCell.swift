//
//  EmployeeListCell.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 15.11.2022.
//

import UIKit

class EmployeeListCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var maritalStatusLabel: UILabel!
    @IBOutlet var developerTypeLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model employee: EmployeeProtocol){
        nameLabel.text = employee.name
        ageLabel.text = String(employee.age)
        maritalStatusLabel.text = employee.maritalStatus.rawValue
        developerTypeLabel.text = employee.developerType?.rawValue
        salaryLabel.text = String(employee.salary!)
    
    }
    
}
