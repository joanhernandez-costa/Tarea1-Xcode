import UIKit

class GameSettingsViewController: UIViewController {
    
    @IBOutlet weak var cardTimeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var numberOfCardsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLastValues()
    }
    
    static var currentSettings: Settings = Settings(cardTime: 1, numberOfCards: 6)
    static var userName: String = "Jugador"
    
    @IBAction func numberOfCardsSegmentControlAction(_ sender: UISegmentedControl) {
        GameSettingsViewController.currentSettings.numberOfCards = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func cardTimeSegmentControlAction(_ sender: UISegmentedControl) {
        GameSettingsViewController.currentSettings.cardTime = Float(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func acceptSettingsButtonPressed(_ sender: UIButton) {
        GameSettingsViewController.userName = userNameTextField.text!
        SaveLoad.saveUserName(userName: GameSettingsViewController.userName)
        SaveLoad.saveSettings(cardTimeSelectedIndex: cardTimeSegmentedControl.selectedSegmentIndex, numberOfCards: numberOfCardsSegmentedControl.selectedSegmentIndex)
    }
    
    func setLastValues() {
        let lastSettings: [Int] = SaveLoad.readSettings() ?? [0, 0]
        let lastUserName: String = SaveLoad.readUserName() ?? "Jugador"
        
        userNameTextField.text = lastUserName
        cardTimeSegmentedControl.selectedSegmentIndex = lastSettings[0]
        numberOfCardsSegmentedControl.selectedSegmentIndex = lastSettings[1]
    }
}
