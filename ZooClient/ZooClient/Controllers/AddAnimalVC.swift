//
//  AddAnimalsVC.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 17.11.2022.
//

import UIKit

final class AddAnimalVC: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var waterConsumptionTextField: UITextField!
    @IBOutlet private weak var speciesTextField: UITextField!
    @IBOutlet private weak var zookeeperTextField: UITextField!
    weak private var pickerView: UIPickerView?
    private var ageArray = Array(0...30)
    private var waterConsumption = Array(1...20)
    private var animalSpecies = AnimalSpecies.allCases
    private var zookeepers: [ZookeeperProtocol] = []
    var myZoo: Zoo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldOptionsForPicker()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    
    @IBAction func addAnimalButtonClicked(_ sender: Any) {
        guard let myZoo,
              let name = nameTextField.text,
              let ageString = ageTextField.text,
              let age = ageString.toInteger(),
              let waterString = waterConsumptionTextField.text,
              let water = waterString.toInteger(),
              let speciesString = speciesTextField.text,
              let species = AnimalSpecies.type(string: speciesString),
              let zookeeerString = zookeeperTextField.text,
              let zookeeper = zookeepers.first(where: {$0.name == zookeeerString})
        else { return }
        
        let animal = Animals(name: name, age: age, species: species, waterConsumption: water)
        
        myZoo.addAnimals(animal: animal, zooKeeper: zookeeper)
        
        self.dismiss(animated: true)
        
            
       
        
        
                
    }
    
    @IBAction func textFieldsEditingDidBegin(_ sender: Any) {
        pickerView?.reloadAllComponents()
    }
    
    @IBAction func speciesTextFieldEditingDidEnd(_ sender: Any) {
        guard let speciesString = speciesTextField.text,
              let species = AnimalSpecies.type(string: speciesString),
              let myZoo
        else { return }
        
        let filteredKeeper = myZoo.zooKeepers.filter { $0.animalSpecialty == species}
        zookeepers = filteredKeeper
        
    }
    
    
}


extension AddAnimalVC: UIPickerViewDelegate, UITextFieldDelegate {
    
    private func setTextFieldOptionsForPicker(){
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        ageTextField.delegate = self
        waterConsumptionTextField.delegate = self
        speciesTextField.delegate = self
        zookeeperTextField.delegate = self
        
        waterConsumptionTextField.inputView = picker
        zookeeperTextField.inputView = picker
        ageTextField.inputView = picker
        speciesTextField.inputView = picker
        
        self.pickerView = picker
    }
}

extension AddAnimalVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if ageTextField.isFirstResponder {
            return ageArray.count
        }
        else if speciesTextField.isFirstResponder {
            return animalSpecies.count
        }
        else if zookeeperTextField.isFirstResponder {
            return zookeepers.count
        }
        else if waterConsumptionTextField.isFirstResponder {
            return waterConsumption.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if ageTextField.isFirstResponder {
            return ageArray[row].toString()
        }
        else if speciesTextField.isFirstResponder {
            return animalSpecies[row].toString()
        }
        else if zookeeperTextField.isFirstResponder {
            return zookeepers[row].name
        }
        else if waterConsumptionTextField.isFirstResponder {
            return waterConsumption[row].toString()
        }
        return "N/A"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if ageTextField.isFirstResponder {
            ageTextField.text = ageArray[row].toString()
        }
        else if speciesTextField.isFirstResponder {
            speciesTextField.text = animalSpecies[row].toString()
        }
        else if zookeeperTextField.isFirstResponder {
            guard zookeepers.count > 0 else { return  }
            zookeeperTextField.text = zookeepers[row].name
        }
        else if waterConsumptionTextField.isFirstResponder {
            waterConsumptionTextField.text = waterConsumption[row].toString()
        }
    }
}
