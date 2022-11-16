//
//  EmployeeListVC.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 15.11.2022.
//

import UIKit

class EmployeeListVC: UIViewController {

    @IBOutlet weak var employeeTableView: UITableView!
    var myCompany: Company?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard myCompany != nil else { return }
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        
        
        employeeTableView.register(UINib(nibName: "EmployeeListCell", bundle: nil), forCellReuseIdentifier: "EmployeeItemCell")
        
    }
}

extension EmployeeListVC: UITableViewDelegate {
    
}

extension EmployeeListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myCompany!.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeItemCell", for: indexPath) as? EmployeeListCell else { return  UITableViewCell() }
        let employee = myCompany!.employees[indexPath.row]
        cell.configure(model: employee)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
}
