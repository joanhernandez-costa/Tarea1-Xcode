
import Foundation

class gameData: Codable {
    var id: String = ""
    var name: String
    var data: GameInfo
    
    init(name: String, data: GameInfo) {
        self.name = name
        self.data = data
    }
}

class GameInfo: Codable {
    
}
