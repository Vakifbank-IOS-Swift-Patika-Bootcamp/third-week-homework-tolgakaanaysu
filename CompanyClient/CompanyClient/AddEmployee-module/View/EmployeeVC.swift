//
//  EmployeeVC.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 14.11.2022.
//

import UIKit

class EmployeeVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var maritalStatusTextField: UITextField!
    @IBOutlet var developerTypeTextField: UITextField!
    @IBOutlet var salaryLabel: UILabel!
    weak var pickerView: UIPickerView?
    let maritalStatusArray = MaritalStatus.allCases
    let developerTypeArray = DeveloperType.allCases
    var ageArray = Array(18...55)
    var myCompany: Company?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldOptionsForPicker()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
   
    @IBAction func textFieldsEditingChanged(_ sender: UITextField) {
        
        guard let ageString = ageTextField.text else { return }
        guard let age = Int(ageString) else { return }
        guard let developerTypeString = developerTypeTextField.text else { return }
        guard let developerType = DeveloperType(rawValue: developerTypeString) else { return }
        
        salaryLabel.text = String(Employee.calculateSalary(age: age, developerType: developerType)) + "₺"
    }
    
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        pickerView?.reloadAllComponents()
        
    }
    
    @IBAction func addEmployeeButton(_ sender: Any) {
        guard let myCompany else { return }
        guard let name = nameTextField.text else { return }
        guard let ageString = ageTextField.text else { return }
        guard let age = Int(ageString) else { return }
        guard let maritalStatus =  maritalStatusTextField.text else { return }
        guard let developerTypeString = developerTypeTextField.text else { return }
        guard let developerType = DeveloperType(rawValue: developerTypeString) else { return }
        
        let employee = Employee(name: name, age: age, maritalStatus: MaritalStatus(rawValue: maritalStatus)!)
        
        myCompany.addEmployeeToCompany(employee, developerType: developerType)
        self.dismiss(animated: true)
        print(employee.salary ?? 0)
    }
}

//MARK: - UIPickerDelegete
extension EmployeeVC: UIPickerViewDelegate {
    
    private func setTextFieldOptionsForPicker(){
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        maritalStatusTextField.delegate = self
        developerTypeTextField.delegate = self
        ageTextField.delegate = self
        
        maritalStatusTextField.inputView = picker
        developerTypeTextField.inputView = picker
        ageTextField.inputView = picker
        
        self.pickerView = picker
    }
}

//MARK: - UIPickerDataSource
extension EmployeeVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if maritalStatusTextField.isFirstResponder {
            return maritalStatusArray.count
        }
        else if ageTextField.isFirstResponder {
            return ageArray.count
        }
        else if developerTypeTextField.isFirstResponder {
            return developerTypeArray.count
         
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if maritalStatusTextField.isFirstResponder {
            
            maritalStatusTextField.text = maritalStatusArray[row].rawValue
        }
        else if ageTextField.isFirstResponder {
            ageTextField.text = "\(ageArray[row])"
        }
        else if developerTypeTextField.isFirstResponder {
            developerTypeTextField.text =  developerTypeArray[row].rawValue
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if maritalStatusTextField.isFirstResponder {
            
            return maritalStatusArray[row].rawValue
        }
        else if ageTextField.isFirstResponder {
            return "\(ageArray[row])"
        }
        else if developerTypeTextField.isFirstResponder {
            return developerTypeArray[row].rawValue
        }
        return nil
    }
}
