//
//  AddZookeeperVC.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 17.11.2022.
//

import UIKit

final class AddZookeeperVC: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var animalSpecialtyTextField: UITextField!
    @IBOutlet private weak var salaryLabel: UILabel!
    weak private var pickerView: UIPickerView?
    private var ageArray = Array(18...55)
    private var animalSpecialty = AnimalSpecies.allCases
    var myZoo: Zoo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldOptionsForPicker()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        
    }
    
    @IBAction func addZookeeperButtonClicked(_ sender: Any) {
        guard let myZoo,
              let name = nameTextField.text,
              let ageString = ageTextField.text,
              let age = ageString.toInteger(),
              let specialtyString = animalSpecialtyTextField.text,
              let specialty = AnimalSpecies.type(string: specialtyString) else { return }
        
        
        let zookeeper = Zookeeper(name: name, age: age, animalSpecialty: specialty)
        myZoo.addZookeeper(zooKeeper: zookeeper)
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: Any) {
        
        pickerView?.reloadAllComponents()
    }
    
    @IBAction func textFieldsEditingChanged(_ sender: Any) {
        guard
            let ageString = ageTextField.text,
            let age = ageString.toInteger(),
            let specialtyString = animalSpecialtyTextField.text,
            let specialty = AnimalSpecies.type(string: specialtyString)
        else { return }
        
        let salary = Zookeeper.calculateSalary(age: age, animalSpecialty: specialty)
        salaryLabel.text = salary.toString()
        
        
        
    }
    
}

extension AddZookeeperVC: UIPickerViewDelegate, UITextFieldDelegate {
    
    private func setTextFieldOptionsForPicker(){
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        ageTextField.delegate = self
        animalSpecialtyTextField.delegate = self
        
        animalSpecialtyTextField.inputView = picker
        ageTextField.inputView = picker
        
        self.pickerView = picker
    }
}

extension AddZookeeperVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if ageTextField.isFirstResponder {
            return ageArray.count
        }
        else if animalSpecialtyTextField.isFirstResponder {
            return animalSpecialty.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if ageTextField.isFirstResponder {
            return String(ageArray[row])
        }
        else if animalSpecialtyTextField.isFirstResponder {
            return animalSpecialty[row].toString()
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if ageTextField.isFirstResponder {
            ageTextField.text = String(ageArray[row])
        }
        else if animalSpecialtyTextField.isFirstResponder {
            animalSpecialtyTextField.text = animalSpecialty[row].toString()
        }
        
    }
    
}
