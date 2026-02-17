import Foundation

@Observable
class CreatureDetail {
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
        var stats: [Stat]
    }
    
    struct Sprite: Codable {
        var front_default: String
    }
    
    struct Stat: Codable {
        var base_stat: Int
        var stat: StatInfo
    }
    
    struct StatInfo: Codable {
        var name: String
    }
    
    var urlString = ""
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    var baseStats: [String: Int] = [:]
    
    func getData() async {
        print("We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error: Could not create url from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("Error: Could not decode returned json data")
                return
            }
            self.height = returned.height
            self.weight = returned.weight
            self.imageURL = returned.sprites.front_default
            
            // Parse base stats
            self.baseStats = [:]
            for stat in returned.stats {
                self.baseStats[stat.stat.name] = stat.base_stat
            }
        } catch {
            print("Error: Could not get data from \(urlString)")
        }
    }
}
