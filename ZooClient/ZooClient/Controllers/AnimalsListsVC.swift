//
//  AnimalsAndZookeepersListsVC.swift
//  ZooClient
//
//  Created by Tolga Kağan Aysu on 17.11.2022.
//

import UIKit
import AVFoundation
final class AnimalsListsVC: UIViewController {
    
    @IBOutlet private weak var animalsTableView: UITableView!
    var animals: [AnimalsProtocol]?
    
    var bombSoundEffect: AVAudioPlayer?
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard animals != nil else { return }
        title = "Animals List"
        animalsTableView.delegate = self
        animalsTableView.dataSource = self
        
    }
    
    private func playAudioFromProject(name: String) {
        
        guard let data = NSDataAsset(name: name)?.data else { return }
        
        audioPlayer = try? AVAudioPlayer(data: data)
        audioPlayer?.play()
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalType = animals![indexPath.row].species.toString()
        playAudioFromProject(name: animalType.lowercased())
    }
}
