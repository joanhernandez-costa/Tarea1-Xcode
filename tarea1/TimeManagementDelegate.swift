
import Foundation

protocol TimeManagementDelegate: AnyObject {
    func timeStep(currentTime: String, progressUntilTimeLimit: Float)
}
