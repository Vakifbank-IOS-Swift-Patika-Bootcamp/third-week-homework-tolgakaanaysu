//
//  EmployeeVC.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 14.11.2022.
//

import UIKit

final class EmployeeVC: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var maritalStatusTextField: UITextField!
    @IBOutlet private weak var developerTypeTextField: UITextField!
    @IBOutlet private weak var salaryLabel: UILabel!
    weak var pickerView: UIPickerView?
    let maritalStatusArray = MaritalStatus.allCases
    let developerTypeArray = DeveloperType.allCases
    var ageArray = Array(18...55)
    var myCompany: Company?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldOptionsForPicker()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
    
    //MARK: - IBActions
    @IBAction func textFieldsEditingChanged(_ sender: UITextField) {
        
        guard let ageString = ageTextField.text,
              let age = ageString.toInteger(),
              let developerTypeString = developerTypeTextField.text,
              let developerType = developerTypeString.toDeveloperType() else { return }
        
        salaryLabel.text = String(Employee.calculateSalary(age: age, developerType: developerType)) + "₺"
    }
    
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        pickerView?.reloadAllComponents()
    }
    
    @IBAction func addEmployeeButton(_ sender: Any) {
        guard let myCompany ,
              let name = nameTextField.text ,
              let ageString = ageTextField.text ,
              let age = ageString.toInteger() ,
              let maritalStatusString =  maritalStatusTextField.text,
              let maritalStatus = maritalStatusString.toMaritalStatus(),
              let developerTypeString = developerTypeTextField.text ,
              let developerType = developerTypeString.toDeveloperType() else { return }
        
        let employee = Employee(name: name, age: age, maritalStatus: maritalStatus)
        
        myCompany.addEmployeeToCompany(employee, developerType: developerType)
        self.dismiss(animated: true)
    }
}

//MARK: - UIPickerDelegete
extension EmployeeVC: UIPickerViewDelegate, UITextFieldDelegate {
    
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
            
            maritalStatusTextField.text = maritalStatusArray[row].toString
        }
        else if ageTextField.isFirstResponder {
            ageTextField.text = "\(ageArray[row])"
        }
        else if developerTypeTextField.isFirstResponder {
            developerTypeTextField.text =  developerTypeArray[row].toString
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if maritalStatusTextField.isFirstResponder {
            
            return maritalStatusArray[row].toString
        }
        else if ageTextField.isFirstResponder {
            return "\(ageArray[row])"
        }
        else if developerTypeTextField.isFirstResponder {
            return developerTypeArray[row].toString
        }
        return nil
    }
}
