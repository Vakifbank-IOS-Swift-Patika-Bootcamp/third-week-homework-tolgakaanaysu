//
//  Animals.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 16.11.2022.
//

import Foundation

//MARK: - Animals
protocol AnimalsProtocol {
    var id: String { get }
    var name: String { get set }
    var species: AnimalSpecies { get set}
    var age: Int { get set }
    var waterConsumption: Int { get set }
    var zooKeeper : ZookeeperProtocol? { get set }
    var voice: String? { get }
    
    init(name: String, age: Int,species: AnimalSpecies,  waterConsumption: Int)
    
}

final class Animals: AnimalsProtocol {
    var id: String
    var name: String
    var species: AnimalSpecies
    var age: Int
    var waterConsumption: Int
    var zooKeeper: ZookeeperProtocol?
    var voice: String?
    
    required init(name: String, age: Int, species: AnimalSpecies, waterConsumption: Int) {
        self.id = UUID().uuidString
        self.name = name
        self.age = age
        self.species = species
        self.waterConsumption = waterConsumption
        self.voice = species.voice
    }
}

enum AnimalSpecies: CaseIterable {
    case dog
    case cat
    
    var voice: String? {
        switch self {
        case .dog:
            return "hav hav"
        case .cat:
            return "miyav"
        }
    }
    
    var coefficientOfMaintenance: Int {
        switch self {
        case .dog:
            return 2
        case .cat:
            return 1
        }
    }
    
    func toString() -> String {
        switch self {
        case .dog:
            return "Dog"
        case .cat:
            return "Cat"
        }
    }
    
    static func type(string: String) -> Self? {
        switch string {
        case "Dog":
            return .dog
        case "Cat":
            return .cat
        default:
            return nil
        }
    }
}
