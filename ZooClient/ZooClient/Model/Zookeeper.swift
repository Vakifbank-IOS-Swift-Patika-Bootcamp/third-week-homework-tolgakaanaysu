//
//  Zookeeper.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 16.11.2022.
//

import Foundation

//MARK: - Zoo Keeper
protocol ZookeeperProtocol {
    var id: String { get }
    var name: String { get }
    var age: Int { get }
    var animalSpecialty: AnimalSpecies { get }
    var animals: [AnimalsProtocol] { get set}
    var salary: Int { get }
    
    init(name: String, age: Int, animalSpecialty: AnimalSpecies)
}

class Zookeeper: ZookeeperProtocol {
    var id : String
    var name: String
    var age: Int
    var animalSpecialty: AnimalSpecies
    var animals: [AnimalsProtocol]
    var salary: Int {
        return Zookeeper.calculateSalary(age: age, animalSpecialty: animalSpecialty)
    }
    
    required init(name: String, age: Int, animalSpecialty: AnimalSpecies){
        self.id = UUID().uuidString
        self.name = name
        self.age = age
        self.animalSpecialty = animalSpecialty
        self.animals = []
    }
    
    class func calculateSalary(age: Int, animalSpecialty: AnimalSpecies ) -> Int {
        return age * 250 * animalSpecialty.coefficientOfMaintenance
    }
}

