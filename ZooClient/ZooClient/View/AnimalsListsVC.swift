//
//  AnimalsAndZookeepersListsVC.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 17.11.2022.
//

import UIKit

final class AnimalsListsVC: UIViewController {
    
    @IBOutlet private weak var animalsTableView: UITableView!
    var animals: [AnimalsProtocol]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard animals != nil else { return }
        animalsTableView.delegate = self
        animalsTableView.dataSource = self
        
    }
}

extension AnimalsListsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalsListCell", for: indexPath) as! AnimalsListCell
        let animal = animals![indexPath.row]
        cell.configurationUI(animal: animal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals!.count
    }
}
