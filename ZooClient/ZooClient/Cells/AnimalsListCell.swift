//
//  AnimalsListCell.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 20.11.2022.
//

import UIKit

final class AnimalsListCell: UITableViewCell {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!
    @IBOutlet weak private var speciesLabel: UILabel!
    @IBOutlet weak private var  waterConsumption: UILabel!
    @IBOutlet weak private var  zookeeperLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configurationUI(animal: AnimalsProtocol){
        nameLabel.text = animal.name
        ageLabel.text = animal.age.toString()
        speciesLabel.text = animal.species.toString()
        waterConsumption.text = animal.waterConsumption.toString()
        zookeeperLabel.text = animal.zooKeeper?.name
        self.layer.cornerRadius = 60
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray.cgColor
    }

}
