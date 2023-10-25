import Foundation
import UIKit

class Settings: Codable {
    
    public var cardTime: Float = 0.0
    public var numberOfCards: Int = 0
    
    init(cardTime: Float, numberOfCards: Int) {
        self.cardTime = cardTime
        self.numberOfCards = numberOfCards
    }
}
