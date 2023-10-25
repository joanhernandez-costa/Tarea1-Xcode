//
//  TestViewController.swift
//  tarea1
//
//  Created by user197292 on 10/25/23.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var cardTimeLabel: UILabel!
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    let gameSettings: Settings = GameSettingsViewController.currentSettings

    override func viewDidLoad() {
        super.viewDidLoad()

        cardTimeLabel.text = "cardTime = " + String(gameSettings.cardTime)
        numberOfCardsLabel.text = "numberOfCards = " + String(gameSettings.numberOfCards)
    }


}
