
import Foundation

struct Characters: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Character]
    
    var numberOfCharacters: Int {
        return results.count
    }
}

