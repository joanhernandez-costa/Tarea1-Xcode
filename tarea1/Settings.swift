import Foundation
import UIKit

class Settings: Codable {
    
    var cardTime: Float
    var numberOfCards: Int
    var timeLimit: Int
    
    init(cardTime: Float, numberOfCards: Int, timeLimit: Int) {
        self.cardTime = cardTime
        self.numberOfCards = numberOfCards
        self.timeLimit = timeLimit
    }
}
