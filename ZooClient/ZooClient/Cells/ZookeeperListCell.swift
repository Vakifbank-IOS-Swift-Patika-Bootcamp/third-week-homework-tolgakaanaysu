//
//  ZookeeperListCell.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 19.11.2022.
//

import UIKit

final class ZookeeperListCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var specialtyLabel: UILabel!
    @IBOutlet private weak var salaryLabel: UILabel!
    @IBOutlet private weak var animalsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configurationUI(zookeeper: ZookeeperProtocol){
        nameLabel.text = zookeeper.name
        ageLabel.text = zookeeper.age.toString()
        specialtyLabel.text = zookeeper.animalSpecialty.toString()
        salaryLabel.text = zookeeper.salary.toString()
        animalsLabel.text = zookeeper.animals.nameCombine()
        self.layer.cornerRadius = 60
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray.cgColor
    }

}
