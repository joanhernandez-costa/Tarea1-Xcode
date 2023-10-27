import UIKit

class GameSettingsViewController: UIViewController {
    
    @IBOutlet weak var cardTimeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var numberOfCardsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLastValues()
    }
    
    var currentSettings: Settings = SaveLoad.readSettings()
    //static var currentSettings: Settings = Settings(cardTime: 0.3, numberOfCards: 12)
    static var userName: String = "Jugador"
    
    @IBAction func numberOfCardsSegmentControlAction(_ sender: UISegmentedControl) {
        currentSettings.numberOfCards = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func cardTimeSegmentControlAction(_ sender: UISegmentedControl) {
        currentSettings.cardTime = Float(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    @IBAction func acceptSettingsButtonPressed(_ sender: UIButton) {
        GameSettingsViewController.userName = userNameTextField.text!
        SaveLoad.saveUserName(userName: GameSettingsViewController.userName)
        
        SaveLoad.saveSettingsIndex(cardTimeSelectedIndex: cardTimeSegmentedControl.selectedSegmentIndex, numberOfCardsIndex: numberOfCardsSegmentedControl.selectedSegmentIndex)
        SaveLoad.saveSettings(cardTime: currentSettings.cardTime, numberOfCards: currentSettings.numberOfCards)
    }
    
    func setLastValues() {
        let lastSettings: [Int] = SaveLoad.readSettingsIndex() ?? [0, 0]
        let lastUserName: String = SaveLoad.readUserName() ?? "Jugador"
        
        userNameTextField.text = lastUserName
        cardTimeSegmentedControl.selectedSegmentIndex = lastSettings[0]
        numberOfCardsSegmentedControl.selectedSegmentIndex = lastSettings[1]
        
    }
}
