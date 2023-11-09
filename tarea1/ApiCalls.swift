
import Foundation

var ids: [String] = []

class ApiCalls {
    let baseURL = URL(string: "https://api.restful-api.dev/objects?")
    
    init(){}
    
    func getGame() {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: self.baseURL!)
                DispatchQueue.main.async {
                    //
                }
            } catch {
                
            }
        }
    }
    
    func postGame(game: GameData) {
        let data = try! JSONEncoder().encode(game)
        var request = URLRequest(url: baseURL!)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let json = String(data: data!, encoding: .utf8)
            print(json ?? "Error en postGame")
            do {
                let gameDataJSON = try JSONDecoder().decode(GameData.self, from: data!)
                ids.append(gameDataJSON.id)
            } catch {
                print("Error parseo JSON")
            }
        }.resume()
    }
    
    func getGames() {
        print("Get Games")
        let url = URL(string: generateURL())
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let json = String(data: data!, encoding: .utf8)
            print(json ?? "Error en getGames")
            do {
                let gameDataJSON = try JSONDecoder().decode([GameData].self, from: data!)
                ScoreRecordTableViewController.scoreRecord = gameDataJSON
                DispatchQueue.main.async {
                    ScoreRecordTableViewController().scoreRecordTableView.reloadData()
                }
            } catch {
                print("Error en parseo JSON")
            }
        }.resume()
    }
    
    func generateURL() -> String {
        var url = "https://api.restful-api.dev/objects?"
        for id in ids {
            url += "id=" + id + "&"
        }
        url.removeLast()
        return url
    }
}
