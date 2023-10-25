import Foundation

class Game: Codable {
    
    var userName: String = ""
    var score: Float = 0.0
    var durationOfGame: Float = 0.0
    var dateOfTheGame: String = ""
    
    init(userName: String, score: Float, durationOfGame: Float, dateOfTheGame: String) {
        self.userName = userName
        self.score = score
        self.durationOfGame = durationOfGame
        self.dateOfTheGame = dateOfTheGame
    }
    
    //Poner este método en la clase donde se guarde una partida: Game
    func getCurrentShortDate() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        return dateFormatter.string(from: todaysDate as Date)
    }
}
