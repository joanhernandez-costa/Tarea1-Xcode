import Foundation

class SaveLoad {
    
    static func saveGame(userName: String, score: Float, durationOfGame: Float, dateOfTheGame: String) {
        let game: Game = Game(userName: userName, score: score, durationOfGame: durationOfGame, dateOfTheGame: dateOfTheGame)
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(game) {
            UserDefaults.standard.setValue(data, forKey: "gameData")
        }
    }
    
    static func readGame() -> Game {
        let data = UserDefaults.standard.object(forKey: "gameData") as! Data
        let decoder = JSONDecoder()
        var defaultGame = Game(userName: "", score: 0, durationOfGame: 0, dateOfTheGame: "dd-MM-yyyy")
        if let game = try? decoder.decode(Game.self, from: data) {
            defaultGame = game
        }
        return defaultGame
    }
    
    static func saveSettings(cardTimeSelectedIndex: Int, numberOfCards: Int) {
        UserDefaults.standard.setValue(cardTimeSelectedIndex, forKey: "cardTimeSelectedIndex")
        UserDefaults.standard.setValue(numberOfCards, forKey: "numberOfCardsSelectedIndex")
    }
    
    static func readSettings() -> [Int]? {
        return [UserDefaults.standard.integer(forKey: "cardTimeSelectedIndex"), UserDefaults.standard.integer(forKey: "numberOfCardsSelectedIndex")]
    }
    
    static func saveUserName(userName: String) {
        UserDefaults.standard.setValue(userName, forKey: "userName")
    }
    
    static func readUserName() -> String? {
        return UserDefaults.standard.string(forKey: "userName")
    }
    
    /*
    func saveObjectWithKey(object: Any, key: String) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(object) {
            UserDefaults.standard.setValue(data, forKey: "key")
        }
    }
    
    func readObject(key: String) -> Any {
        
    }
    */
}
