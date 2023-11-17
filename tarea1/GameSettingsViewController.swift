import UIKit

//Variables currentSettings y userName, accesibles desde otras clases para usar la información almacenada.
var currentSettings: Settings = SaveLoad.readSettings()
var userName: String = SaveLoad.readUserName()!

class GameSettingsViewController: UIViewController {
    
    //Referencias a los SegmentedControl y TextField para recoger información en el momento indicado
    @IBOutlet weak var cardTimeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var numberOfCardsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timeLimitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLastValues()
    }
    
    //Se ejecuta cada vez que el SegmentedControl del número de cartas cambia de segmento seleccionado
    @IBAction func numberOfCardsSegmentControlAction(_ sender: UISegmentedControl) {
        currentSettings.numberOfCards = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    //Se ejecuta cada vez que el SegmentedControl de la velocidad de carta cambia de segmento seleccionado.
    @IBAction func cardTimeSegmentControlAction(_ sender: UISegmentedControl) {
        currentSettings.cardTime = Float(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    //Se ejecuta cada vex que el SegmentedControl de límite de tiempo cambia de segmento seleccionado.
    @IBAction func timeLimitSegmentedControlAction(_ sender: UISegmentedControl) {
        currentSettings.timeLimit = Int(sender.titleForSegment(at: sender.selectedSegmentIndex)!)!
    }
    
    //Se ejecuta cuando se pulsa el botón aceptar. Se guarda el nombre de usuario introducido, los indices del segmento seleccionado y el valor del segmento seleccionado
    @IBAction func acceptSettingsButtonPressed(_ sender: UIButton) {
        userName = userNameTextField.text!
        SaveLoad.saveUserName(userName: userName)
        
        SaveLoad.saveSettingsIndex(cardTimeSelectedIndex: cardTimeSegmentedControl.selectedSegmentIndex, numberOfCardsIndex: numberOfCardsSegmentedControl.selectedSegmentIndex, timeLimitIndex: timeLimitSegmentedControl.selectedSegmentIndex)
        SaveLoad.saveSettings(cardTime: currentSettings.cardTime, numberOfCards: currentSettings.numberOfCards, timeLimit: currentSettings.timeLimit)
    }
    
    //Carga el nombre y los settings introducidos en la última partida
    func setLastValues() {
        let lastSettings: [Int] = SaveLoad.readSettingsIndex()!
        let lastUserName: String = SaveLoad.readUserName()!
        
        userNameTextField.text = lastUserName
        cardTimeSegmentedControl.selectedSegmentIndex = lastSettings[0]
        numberOfCardsSegmentedControl.selectedSegmentIndex = lastSettings[1]
        timeLimitSegmentedControl.selectedSegmentIndex = lastSettings[2]
        
    }
}
