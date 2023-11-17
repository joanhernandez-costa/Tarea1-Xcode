
import Foundation

class OrderCriteria {
    
    let originalList = ScoreRecordTableViewController.scoreRecordToShow
    var previouslySelected: [Bool] = [false, false, false, false]
    
    func orderByScore(indexOfTitlePressed: Int) -> [GameData] {
        let isAscending = previouslySelected[indexOfTitlePressed]
        previouslySelected[indexOfTitlePressed].toggle() //Cambia el estado para la próxima llamada.

        if isAscending {
            // Orden ascendente
            return originalList.sorted { $0.data.score < $1.data.score }
        } else {
            // Orden descendente
            return originalList.sorted { $1.data.score < $0.data.score }
        }
    }

    
    func orderByUserName(indexOfTitlePressed: Int) -> [GameData] {
        let isAscending = previouslySelected[indexOfTitlePressed]
        previouslySelected[indexOfTitlePressed].toggle()

        if isAscending {
            return originalList.sorted { $0.data.userName < $1.data.userName }
        } else {
            return originalList.sorted { $1.data.userName < $0.data.userName }
        }
    }

    func orderByTime(indexOfTitlePressed: Int) -> [GameData] {
        let isAscending = previouslySelected[indexOfTitlePressed]
        previouslySelected[indexOfTitlePressed].toggle()

        if isAscending {
            // Orden ascendente
            return originalList.sorted { $0.data.durationOfGame < $1.data.durationOfGame }
        } else {
            // Orden descendente
            return originalList.sorted { $1.data.durationOfGame < $0.data.durationOfGame }
        }
    }

    
    func orderByDate(indexOfTitlePressed: Int) -> [GameData] {
        let isAscending = previouslySelected[indexOfTitlePressed]
        previouslySelected[indexOfTitlePressed].toggle()

        if isAscending {
            // Orden ascendente
            return originalList.sorted { $0.data.dateOfTheGame < $1.data.dateOfTheGame }
        } else {
            // Orden descendente
            return originalList.sorted { $1.data.dateOfTheGame < $0.data.dateOfTheGame }
        }
    }
}
