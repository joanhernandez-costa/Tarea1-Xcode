import UIKit

class GameSettingsViewController: UIViewController {
    
    public var currentSettings: Settings = Settings(cardTime: 1, numberOfCards: 6)
    public var userName: String = "Jugador"
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBAction func numberOfCardsSegmentControlAction(_ sender: UISegmentedControl) {
        currentSettings.numberOfCards = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func cardTimeSegmentControlAction(_ sender: UISegmentedControl) {
        currentSettings.cardTime = Float(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func acceptSettingsButtonPressed(_ sender: UIButton) {
        userName = userNameTextField.text!
        print(currentSettings.cardTime)
        print(currentSettings.numberOfCards)
    }
}
