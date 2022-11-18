//
//  ViewController.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 16.11.2022.
//

import UIKit

class HomepageVC: UIViewController {
    
    @IBOutlet private weak var waterLimitLabel: UILabel!
    @IBOutlet private weak var incomeLabel: UILabel!
    @IBOutlet private weak var expenseLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var addIncomeTextField: UITextField!
    @IBOutlet private weak var addExpenseTextField: UITextField!
    var myZoo: Zoo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setZoo()
        setLabels()
        
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
    
    
    // Go to animal & zookeper lists page
    @IBAction func goToZookeeperAnimalListButtonClicked(_ sender: Any) {
        
        guard let listsVC = storyboard?.instantiateViewController(withIdentifier: "AnimalsVC_ID") as? AnimalsListsVC else { return }
        self.navigationController?.pushViewController(listsVC, animated: true)
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

