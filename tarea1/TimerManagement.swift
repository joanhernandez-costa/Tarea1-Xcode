
import Foundation

class TimeManagement {
    
    var timer: Timer = Timer()
    var delegate: TimeManagementDelegate?
    
    init() {}
    
    //Configura un timer que se ejecute cada cardTime segundos
    func timerOn() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(currentSettings.cardTime), target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        seconds = 0; minutes = 0
    }
    
    //Configura un timer que se ejecute en un intervalo deseado.
    func timerOnEachSeconds(interval: Double) {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //Configura un timer que se ejecuta una vez después de esperar una cantidad de segundos.
    func waitSeconds(interval: Double) {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: false)
    }
    
    func timerOff() {
        timer.invalidate()
    }
    
    //Actualiza los valores de los segundos y minutos actuales
    var seconds: Int = 0
    var minutes: Int = 0
    @objc func updateTimer() {
        
        if seconds == 59 {
            seconds = 0
            minutes += 1
        } else {
            seconds += 1
        }
        
        delegate?.timeStep(currentTime: getParsedTimeSinceTimerOn(), progressUntilTimeLimit: Float(seconds) / Float(currentSettings.timeLimit))
    }
    
    //Parsea y devuelve un String con el tiempo actual cada segundo.
    func getParsedTimeSinceTimerOn() -> String {
    
        if seconds < 10 {
            return "0" + String(minutes) + ":0" + String(seconds)
        } else {
            return "0" + String(minutes) + ":" + String(seconds)
        }
    }
}
