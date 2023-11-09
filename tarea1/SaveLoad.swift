import Foundation

class SaveLoad {
    
    //Guarda partida, recibiendo los parámetros del obejeto Game por separado
    static func saveGame(game: Game) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(game) {
            UserDefaults.standard.setValue(data, forKey: "gameData")
        }
    }
    
    //Devuelve objeto Game ya creado.
    static func readGame() -> Game {
        let data = UserDefaults.standard.object(forKey: "gameData") as! Data
        let decoder = JSONDecoder()
        var defaultGame = Game(userName: "", score: 0.0, durationOfGame: "", dateOfTheGame: "dd-MM-yyyy")
        if let game = try? decoder.decode(Game.self, from: data) {
            defaultGame = game
        }
        return defaultGame
    }
    
    //Guarda los settings introducidos, con los parámetros por separado.
    static func saveSettings(cardTime: Float, numberOfCards: Int, timeLimit: Int) {
        let settings: Settings = Settings(cardTime: cardTime, numberOfCards: numberOfCards, timeLimit: timeLimit)
        let enconder = JSONEncoder()
        if let data = try? enconder.encode(settings) {
            UserDefaults.standard.setValue(data, forKey: "gameSettings")
        }
    }
    
    //Devuelve objeto Settings ya creado.
    static func readSettings() -> Settings {
        let data = UserDefaults.standard.object(forKey: "gameSettings") as! Data
        let decoder = JSONDecoder()
        var defaultSettings = Settings(cardTime: 0.0, numberOfCards: 0, timeLimit: 0)
        if let settings = try? decoder.decode(Settings.self, from: data) {
            defaultSettings = settings
        }
        return defaultSettings
    }
    
    //Guarda los índices de los segmentos seleccionados en vista GameSettings
    static func saveSettingsIndex(cardTimeSelectedIndex: Int, numberOfCardsIndex: Int, timeLimitIndex: Int) {
        UserDefaults.standard.setValue(cardTimeSelectedIndex, forKey: "cardTimeSelectedIndex")
        UserDefaults.standard.setValue(numberOfCardsIndex, forKey: "numberOfCardsSelectedIndex")
        UserDefaults.standard.setValue(timeLimitIndex, forKey: "timeLimitSelectedIndex")
    }
    
    //Devuelve un array de índices. [0] = cardTime, [1] = numberOfCards, [2] = timeLimit.
    static func readSettingsIndex() -> [Int]? {
        return [UserDefaults.standard.integer(forKey: "cardTimeSelectedIndex"),
                UserDefaults.standard.integer(forKey: "numberOfCardsSelectedIndex"),
                UserDefaults.standard.integer(forKey: "timeLimitSelectedIndex")]
    }
    
    static func saveUserName(userName: String) {
        UserDefaults.standard.setValue(userName, forKey: "userName")
    }
    
    static func readUserName() -> String? {
        return UserDefaults.standard.string(forKey: "userName")
    }
}
