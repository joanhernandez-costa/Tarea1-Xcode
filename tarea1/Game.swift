import Foundation
import UIKit

class Game: Codable {
    
    var userName: String
    var score: Float
    var durationOfGame: String
    var dateOfTheGame: String
    
    init(userName: String, score: Float, durationOfGame: String, dateOfTheGame: String) {
        self.userName = userName
        self.score = score
        self.durationOfGame = durationOfGame
        self.dateOfTheGame = dateOfTheGame
    }
    
    //Función para calcular puntuación. Función utilizada: (n * p) / (v + t)
    static func calculateScore(timeProgressView: UIProgressView, userGuessOrder: [Int], cardOrder: [Int]) -> Float {
        /* n = número de cartas
        p = número de aciertos
        v = velocidad a la que pasan las cartas
        t = porcentaje de tiempo límite ocupado */
        
        let numberOfCards: Float = Float(currentSettings.numberOfCards)
        var rightGuesses: Float = 0.0
        let cardTime: Float = currentSettings.cardTime
        let durationOfTheGame: Float = timeProgressView.progress
        
        let maxScorePossible = (numberOfCards * 2) / cardTime + 0 //144
        for i in 0..<currentSettings.numberOfCards {
            if userGuessOrder[i] == cardOrder[i] {
                rightGuesses += 1.0
            }
        }
        
        let score = (numberOfCards * rightGuesses) / (cardTime + durationOfTheGame)
        return round((10 * (score / Float(maxScorePossible))) * 100) / 100
    }
}

class GameData: Codable {
    var id: String = ""
    var name: String
    var data: Game
    
    init(name: String, data: Game) {
        self.name = name
        self.data = data
    }
}
