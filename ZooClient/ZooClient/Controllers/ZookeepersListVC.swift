//
//  ZookeepersList.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 19.11.2022.
//

import UIKit

final class ZookeepersListVC: UIViewController {

    @IBOutlet private weak var zookeepersTableview: UITableView!
    
    var zookepers: [ZookeeperProtocol]?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard zookepers != nil else { return }
        title = "Zookeeper List"
        zookeepersTableview.dataSource = self
        zookeepersTableview.delegate = self
        
    }
}

extension ZookeepersListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        zookepers!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "zookeeperListCell", for: indexPath) as? ZookeeperListCell else { return UITableViewCell()}
        let zookeeper = zookepers![indexPath.row]
        
        cell.configurationUI(zookeeper: zookeeper)
        return cell
    }
    
   
}
