//
//  ViewController.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 16.11.2022.
//

import UIKit

final class HomepageVC: UIViewController {
    
    @IBOutlet private weak var waterLimitLabel: UILabel!
    @IBOutlet private weak var incomeLabel: UILabel!
    @IBOutlet private weak var expenseLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var addIncomeTextField: UITextField!
    @IBOutlet private weak var addExpenseTextField: UITextField!
    var myZoo: Zoo! {
        didSet{
            setWaterLimitLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setZoo()
        setLabels()
        
        
        let zookeeper1 = Zookeeper(name: "Ahmet", age: 23, animalSpecialty: .cat)
        let zookeeper2 = Zookeeper(name: "Ceyda", age: 35, animalSpecialty: .dog)
        
        let animal1 = Animals(name: "Duman", age: 2, species: .dog, waterConsumption: 4)
        let animal2 = Animals(name: "Şakir", age: 1, species: .cat, waterConsumption: 1)
        let animal3 = Animals(name: "Pamuk", age: 3, species: .cat, waterConsumption: 2)
        
        myZoo.addZookeeper(zooKeeper: zookeeper1)
        myZoo.addZookeeper(zooKeeper: zookeeper2)
       
        
        myZoo.addAnimals(animal: animal1, zooKeeper: zookeeper2)
        myZoo.addAnimals(animal: animal2, zooKeeper: zookeeper1)
        myZoo.addAnimals(animal: animal3, zooKeeper: zookeeper1)
        
    }
    
    @IBAction func addIncomeButtonClicked(_ sender: Any) {
        guard let amountString = addIncomeTextField.text,
              let amount = Int(amountString) else { return }
        
        myZoo.addToIncome(at: amount)
        setIncomeLabel()
        setBalanceLabel()
    }
    
    @IBAction func addExpenseButtonClicked(_ sender: Any) {
        guard let amountString = addExpenseTextField.text,
              let amount = Int(amountString) else { return }
        myZoo.addToExpenses(at: amount)
        setExpenseLabel()
        setBalanceLabel()
    }
    
    @IBAction func paySalaryButtonClicked(_ sender: Any) {
        myZoo.paySalary()
        setBalanceLabel()
    }
    
    
    // Go to add animal page
    @IBAction func addAnimalButtonClicked(_ sender: Any) {
        guard let addAnimalVC = storyboard?.instantiateViewController(withIdentifier: "AddAnimalsVC_ID") as? AddAnimalVC else { return }
        addAnimalVC.myZoo = myZoo
        present(addAnimalVC, animated: true)
    }
    
    
    // Go to add zookeeper page
    @IBAction func addZookeeperButtonClicked(_ sender: Any) {
      
        guard let addZookeeperVC = storyboard?.instantiateViewController(withIdentifier: "AddZookeeperVC_ID") as? AddZookeeperVC else { return }
        addZookeeperVC.myZoo = myZoo
        present(addZookeeperVC, animated: true)
        
    }
    
    
    @IBAction func zookeepersButtonClicked(_ sender: Any) {
        guard let zookeeperListVC = storyboard?.instantiateViewController(withIdentifier: "ZookeepersListVC_ID") as? ZookeepersListVC else { return }
        zookeeperListVC.zookepers = myZoo.zooKeepers
        navigationController?.pushViewController(zookeeperListVC, animated: true)
        
    }
   
    @IBAction func animalsButtonClicked(_ sender: Any) {
        guard let animalsListVC = storyboard?.instantiateViewController(withIdentifier: "AnimaListsVC_ID") as? AnimalsListsVC else { return }
        animalsListVC.animals = myZoo.allAnimals
        navigationController?.pushViewController(animalsListVC, animated: true)
    }
    
    private func setZoo(){
        myZoo = Zoo(waterLimit: 100)
    }
    
    private func setLabels(){
        setWaterLimitLabel()
        setIncomeLabel()
        setExpenseLabel()
        setBalanceLabel()
    }
    
    private func setWaterLimitLabel() {
        waterLimitLabel.text = String(myZoo.waterLimit)
    }
    
    private func setExpenseLabel() {
        expenseLabel.text = String(myZoo.expenses)
    }
    
    private func setIncomeLabel() {
        incomeLabel.text = String(myZoo.income)
    }
    
    private func setBalanceLabel() {
        balanceLabel.text = String(myZoo.balance)
    }
}

