import Foundation

class SaveLoad {
    
    static let userDefaults = UserDefaults.standard
    
    //Guarda partida, recibiendo los parámetros del obejeto Game por separado
    static func saveGame(game: Game) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(game) {
            userDefaults.setValue(data, forKey: "gameData")
        }
    }
    
    //Devuelve objeto Game ya creado.
    static func readGame() -> Game {
        let data = userDefaults.object(forKey: "gameData") as! Data
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
            userDefaults.setValue(data, forKey: "gameSettings")
        }
    }
    
    //Devuelve objeto Settings ya creado.
    static func readSettings() -> Settings {
        let data = userDefaults.object(forKey: "gameSettings") as! Data
        let decoder = JSONDecoder()
        var defaultSettings = Settings(cardTime: 0.0, numberOfCards: 0, timeLimit: 0)
        if let settings = try? decoder.decode(Settings.self, from: data) {
            defaultSettings = settings
        }
        return defaultSettings
    }
    
    //Guarda los índices de los segmentos seleccionados en vista GameSettings
    static func saveSettingsIndex(cardTimeSelectedIndex: Int, numberOfCardsIndex: Int, timeLimitIndex: Int) {
        userDefaults.setValue(cardTimeSelectedIndex, forKey: "cardTimeSelectedIndex")
        userDefaults.setValue(numberOfCardsIndex, forKey: "numberOfCardsSelectedIndex")
        userDefaults.setValue(timeLimitIndex, forKey: "timeLimitSelectedIndex")
    }
    
    //Devuelve un array de índices. [0] = cardTime, [1] = numberOfCards, [2] = timeLimit.
    static func readSettingsIndex() -> [Int]? {
        return [userDefaults.integer(forKey: "cardTimeSelectedIndex"),
                userDefaults.integer(forKey: "numberOfCardsSelectedIndex"),
                userDefaults.integer(forKey: "timeLimitSelectedIndex")]
    }
    
    //Guarda el nombre de usuario
    static func saveUserName(userName: String) {
        userDefaults.setValue(userName, forKey: "userName")
    }
    
    //Devuelve el nombre de usuario
    static func readUserName() -> String? {
        return userDefaults.string(forKey: "userName")
    }
    
    //Guarda la lista de ids después de actualizarse
    static func saveIdsList(ids: [String]) {
        userDefaults.set(ids, forKey: "idsArray")
    }
    
    //Devuelve la lista de ids
    static func readIdsList() -> [String] {
        if let list = userDefaults.array(forKey: "idsArray") as? [String] {
            return list
        }
        return []
    }
}
