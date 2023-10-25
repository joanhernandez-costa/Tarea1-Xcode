import Foundation

class SaveLoad {
    
    func saveGame(userName: String, score: Float, durationOfGame: Float) {
        let game: Game = Game(userName: userName, score: score, durationOfGame: durationOfGame)
        
        UserDefaults.standard.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
    }
    
    func readGame() -> Game {
        
    }
    
    func saveSettings(settings: Settings) {
        
    }
    
    static func saveUserName(userName: String) {
        UserDefaults.standard.setValue(userName, forKey: "userName")
    }
    
    static func readUserName() -> String {
        return UserDefaults.standard.string(forKey: "userName")!
    }
}
