
import Foundation

//Lista de ids para recuperar todas las partidas guardadas
var ids: [String] = SaveLoad.readIdsList()

class ApiCalls {
    let baseURL = URL(string: "https://api.restful-api.dev/objects?")
    
    init(){}
    
    //Sube la última partida jugada.
    func postGame(game: GameData) {
        print("POSTING GAME...")
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
                SaveLoad.saveIdsList(ids: ids)
            } catch {
                print("Error parseo JSON")
            }
        }.resume()
    }
    
    //Devuelve todas las partidas guardadas.
    func getGames() {
        print("GETTING GAMES...")
        let url = URL(string: generateURL())
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let json = String(data: data!, encoding: .utf8)
            print(json ?? "Error en getGames")
            do {
                let gameDataJSON = try JSONDecoder().decode([GameData].self, from: data!)
                ScoreRecordTableViewController.scoreRecordToShow = gameDataJSON
                /*
                DispatchQueue.main.async {
                    ScoreRecordTableViewController().scoreRecordTableView.reloadData()
                }
 */
            } catch {
                print("Error en parseo JSON")
            }
        }.resume()
    }
    
    //Parsea baseURL añadiendo los ids como parámetros.
    func generateURL() -> String {
        var url = "https://api.restful-api.dev/objects?"
        for id in ids {
            url += "id=" + id + "&"
        }
        url.removeLast()
        return url
    }
}
