
import Foundation

struct Character: Decodable, Identifiable {
    var id = UUID()
    let name: String
    let height: String
    let mass: String
    let hairColor: String?
    let skinColor: String?
    let eyeColor: String?
    let birthYear: String?
    let homeworld: String
    let starships: [String]
    let url: String
    
    enum CodingKeys: CodingKey {
        case name, height, mass, hairColor, skinColor, eyeColor, birthYear, homeworld, starships, url
    }
}

extension Character {
    var urlForImage: String? {
        if let number = Character.parseNumber(from: url) { return "https://starwars-visualguide.com/assets/img/characters/\(number).jpg" }
        return nil
    }
    
    static func parseNumber(from string: String) -> String? {
        return String(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
