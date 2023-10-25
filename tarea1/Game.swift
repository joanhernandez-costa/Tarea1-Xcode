import Foundation

class Game: Codable {
    
    var userName: String = ""
    var score: Float = 0.0
    var durationOfGame: Float = 0.0
    
    init(userName: String, score: Float, durationOfGame: Float) {
        self.userName = userName
        self.score = score
        self.durationOfGame = durationOfGame
    }
}
