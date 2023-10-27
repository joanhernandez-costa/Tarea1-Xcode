import Foundation

class SaveLoad {
    
    static func saveGame(userName: String, score: Float, durationOfGame: String, dateOfTheGame: String) {
        let game: Game = Game(userName: userName, score: score, durationOfGame: durationOfGame, dateOfTheGame: dateOfTheGame)
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(game) {
            UserDefaults.standard.setValue(data, forKey: "gameData")
        }
    }
    
    static func readGame() -> Game {
        let data = UserDefaults.standard.object(forKey: "gameData") as! Data
        let decoder = JSONDecoder()
        var defaultGame = Game(userName: "", score: 0, durationOfGame: "", dateOfTheGame: "dd-MM-yyyy")
        if let game = try? decoder.decode(Game.self, from: data) {
            defaultGame = game
        }
        return defaultGame
    }
    
    static func saveSettings(cardTime: Float, numberOfCards: Int) {
        let settings: Settings = Settings(cardTime: cardTime, numberOfCards: numberOfCards)
        let enconder = JSONEncoder()
        if let data = try? enconder.encode(settings) {
            UserDefaults.standard.setValue(data, forKey: "gameSettings")
        }
    }
    
    static func readSettings() -> Settings {
        let data = UserDefaults.standard.object(forKey: "gameSettings") as! Data
        let decoder = JSONDecoder()
        var defaultSettings = Settings(cardTime: 0.0, numberOfCards: 0)
        if let settings = try? decoder.decode(Settings.self, from: data) {
            defaultSettings = settings
        }
        return defaultSettings
    }
    
    static func saveSettingsIndex(cardTimeSelectedIndex: Int, numberOfCardsIndex: Int) {
        UserDefaults.standard.setValue(cardTimeSelectedIndex, forKey: "cardTimeSelectedIndex")
        UserDefaults.standard.setValue(numberOfCardsIndex, forKey: "numberOfCardsSelectedIndex")
    }
    
    static func readSettingsIndex() -> [Int]? {
        return [UserDefaults.standard.integer(forKey: "cardTimeSelectedIndex"), UserDefaults.standard.integer(forKey: "numberOfCardsSelectedIndex")]
    }
    
    static func saveUserName(userName: String) {
        UserDefaults.standard.setValue(userName, forKey: "userName")
    }
    
    static func readUserName() -> String? {
        return UserDefaults.standard.string(forKey: "userName")
    }
}
