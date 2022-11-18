//
//  ViewController.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 14.11.2022.
//

import UIKit

class CompanyVC: UIViewController {
    
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var companyFoundationYearLabel: UILabel!
    @IBOutlet var companyAddresLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var addMoneyTextField: UITextField!
    @IBOutlet var withdrowMoneyTextField: UITextField!
    var myCompany: Company!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCompany()
        
        let tolga = Employee(name: "Tolga", age: 25, maritalStatus: .married)
        myCompany.addEmployeeToCompany(tolga, developerType: .mid)
        
        let kaan = Employee(name: "Kağan", age: 25, maritalStatus: .single)
        myCompany.addEmployeeToCompany(kaan, developerType: .senior)
        
        
    }
    
    @IBAction func addMoneyButton(_ sender: Any) {
        guard let amount = addMoneyTextField.text  else {
            return
        }
        guard let intAmount = Int(amount) else {
            return
        }
        myCompany.addToBalance(at: intAmount)
        setBalanceLabelText()
        
    }
    
    @IBAction func withdrowMoneyButton(_ sender: Any) {
        guard let amount = withdrowMoneyTextField.text  else {
            return
        }
        guard let intAmount = Int(amount) else {
            return
        }
        myCompany.withdrawFromBalance(at: intAmount)
        setBalanceLabelText()
    }
    
    @IBAction func paySalaryButton(_ sender: Any) {
        myCompany.paySalaries()
        setBalanceLabelText()
    }
    
    // Open add employee page
    @IBAction func addEmployeeButton(_ sender: Any) {
        guard let employeeVC = storyboard?.instantiateViewController(withIdentifier: "EmployeeVC_ID") as? EmployeeVC else { return }
        employeeVC.myCompany = myCompany
        present(employeeVC, animated: true)
    }
    
    // Go to employee list page
    @IBAction func goEmployeeListButton(_ sender: Any) {
        guard let employeeListVC = storyboard?.instantiateViewController(withIdentifier: "EmployeeListVC_ID") as? EmployeeListVC else { return }
        employeeListVC.myCompany = myCompany
        self.navigationController?.pushViewController(employeeListVC, animated: true)
    }
    
    private func setBalanceLabelText(){
        balanceLabel.text = "\(myCompany.balance)₺"
    }
    
    private func setCompany(){
        myCompany =  Company(name: "Invented Studios", foundationYear: 2022, addres: "İstanbul-Ataşehir", balance: 4000)
        companyNameLabel.text = myCompany.name
        companyAddresLabel.text = myCompany.addres
        companyFoundationYearLabel.text = String(myCompany.foundationYear)
        balanceLabel.text = String(myCompany.balance)
    }
}

