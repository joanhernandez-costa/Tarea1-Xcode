import UIKit

class GameSettingsViewController: UIViewController {
    
    static var currentSettings: Settings = Settings(cardTime: 1, numberOfCards: 6)
    var userName: String = "Jugador"
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBAction func numberOfCardsSegmentControlAction(_ sender: UISegmentedControl) {
        GameSettingsViewController.currentSettings.numberOfCards = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func cardTimeSegmentControlAction(_ sender: UISegmentedControl) {
        GameSettingsViewController.currentSettings.cardTime = Float(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func acceptSettingsButtonPressed(_ sender: UIButton) {
        userName = userNameTextField.text!
        SaveLoad.saveUserName(userName: userName)
        //Guardar nombre de usuario
        //Guardar current Settings
    }
}
