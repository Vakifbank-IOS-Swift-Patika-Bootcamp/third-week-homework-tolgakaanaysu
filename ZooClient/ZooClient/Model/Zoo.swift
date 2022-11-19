//
//  Zoo.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 16.11.2022.
//

import Foundation

//MARK: - Zoo
protocol ZooProtocol {
    var waterLimit: Int { get set}
    var zooKeepers: [ZookeeperProtocol] { get set}
    var balance: Int { get set }
    var allAnimals: [AnimalsProtocol] { get set}
    var expenses: Int { get set }
    var income: Int  { get set }
    
    // Add animals to zoo
     func addAnimals(animal: AnimalsProtocol, zooKeeper: ZookeeperProtocol)
    
    // Add zoo keeper to zoo
     func addZookeeper(zooKeeper: ZookeeperProtocol)
    
    //Increase water limit to zoo
     func increaseWaterLimit(at: Int)
    
    // Pay zoo keeper's salary
     func paySalary()
    
    // Add money to zoo account
     func addToBalance(at amount : Int)
    
    // Add income to zoo
     func addToIncome(at amount : Int)
    
    // Add expense to zoo
     func addToExpenses(at amount : Int)
    
}

extension Array where Element == AnimalsProtocol {
    
    // Calculate all animals water consumption
    func getTotalWaterConsumption() -> Int {
        var total = 0
        for animal in self {
            total += animal.waterConsumption
        }
        return total
    }
}

final class Zoo: ZooProtocol {
    var waterLimit: Int
    var balance: Int = 0
    var zooKeepers: [ZookeeperProtocol] = []
    
    var allAnimals: [AnimalsProtocol] = [] {
        didSet {
            let oldWaterConsumption = oldValue.getTotalWaterConsumption()
            let newWaterConsumption = allAnimals.getTotalWaterConsumption()
            waterLimit -= newWaterConsumption - oldWaterConsumption
        }
    }
    
    var expenses: Int = 0 {
        didSet{
            balance -= (expenses - oldValue)
        }
    }
    
    var income: Int = 0 {
        didSet{
            balance += (income - oldValue)
        }
    }
    
    init(waterLimit: Int){
        self.waterLimit = waterLimit
    }
}

extension Zoo {
    
     func addAnimals(animal: AnimalsProtocol, zooKeeper: ZookeeperProtocol) {
        // check does zoo keeper work at zoo
        guard  zooKeepers.contains(where: {$0.id == zooKeeper.id}) else {
            print("\(zooKeeper.name) adlı bakıcı bulunamadı.. \(animal.name) hayvanat bahçesine eklenemedi :(")
            return
        }
        
        //check is water limit enough
        guard waterLimit > animal.waterConsumption else {
            print("Su limiti yetersiz")
            return
        }
        
        // check has animal been added before
        if allAnimals.contains(where: {$0.id == animal.id }) {
            print("\(animal.name) daha önce eklendi")
            return
        }
        else if zooKeepers.contains(where: {$0.id == zooKeeper.id}) {
            var addedAnimal = animal
            var addedZookeeper = zooKeeper
            addedAnimal.zooKeeper = zooKeeper
            addedZookeeper.animals.append(animal)
            allAnimals.append(animal)
            print("\(animal.name) hayvanat bahçesine eklendi. Bakıcısı: \(zooKeeper.name)")
        }
        
    }
    
     func addZookeeper(zooKeeper: ZookeeperProtocol) {
        // check does zoo keeper work at zoo
        if zooKeepers.contains(where: {$0.id == zooKeeper.id}){
            print("\(zooKeeper.name) adlı bakıcı zaten ekli..")
            
        }
        else {
            zooKeepers.append(zooKeeper)
            print("\(zooKeeper.name) adlı bakıcı eklendi..")
        }
    }
    
     func increaseWaterLimit(at limit: Int) {
        waterLimit += limit
    }
    
    
     func paySalary() {
        var total = 0
        for zookeper in zooKeepers {
            total += zookeper.salary
        }
        
        guard total < balance else {
            print("Maaşlar ödenemedi.. Bütçe yetersiz")
            return
        }
        balance -= total
        print("Maaşlar ödendi. Kalan bütçe: \(balance)")
    }
    
   
     func addToBalance(at amount : Int) {
        guard amount > 0 else {
            print("Lütfen 0₺'den büyük bir miktar giriniz")
            return
        }
        
        balance += amount
        print("Bütçeye \(amount)₺ eklendi. Yeni bütçe: \(balance)₺ ")
    }
    
     func addToIncome(at amount: Int) {
        guard amount > 0 else {
            print("Lütfen 0₺'den büyük gelir giriniz")
            return
        }
        
        income += amount
        print("Gelirlere \(amount)₺ eklendi. Toplam gelir: \(income)₺. Yeni bütçe: \(balance)")
    }
    
     func addToExpenses(at amount: Int) {
        guard amount > 0 else {
            print("Lütfen 0₺'den büyük bir miktar giriniz")
            return
        }
        
         guard amount <= income else {
             print("Gelirler giderlerden fazla olamaz")
             return
         }
         
        guard expenses + amount <= balance else {
            print("Giderler bütçeyi aşıyor.. Lütfen bütçeye göre harcayın :)")
            return
        }
        
        expenses += amount
        print("Giderler \(amount)₺ arttı.. Toplam gider: \(expenses)₺. Yeni bütçe: \(balance)")
    }
}


