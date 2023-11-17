
import Foundation

class OrderCriteria {
    
    let originalList = ScoreRecordTableViewController.scoreRecord
    
    func orderByScore() -> [GameData] {
        return originalList.sorted {$0.data.score < $1.data.score}
    }
    
    func orderByUserName() {
        
    }
    
    func orderByTime() {
        
    }
    
    func orderByDate() {
        
    }
}
