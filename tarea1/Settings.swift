import Foundation
import UIKit

class Settings: Codable {
    
    public var cardTime: Float
    public var numberOfCards: Int
    
    init(cardTime: Float, numberOfCards: Int) {
        self.cardTime = cardTime
        self.numberOfCards = numberOfCards
    }
    
    init() {
        self.cardTime = 0.0
        self.numberOfCards = 0
    }
}
