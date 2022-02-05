
import Foundation

struct Offerings: Decodable {
    let items: [VenueAndExibition]
}

// MARK: - Item
struct VenueAndExibition: Decodable, Identifiable {
    
    var id = UUID()
    
    let type: OfferingType
    let name: String
    let image: String
    let priceCurrencyCode: String
    let price: String
    let starsRating: Double?
    let location, startDate, endDate: String?

    enum CodingKeys: String, CodingKey { case type, name, image, priceCurrencyCode, price, starsRating, location, startDate, endDate }
}

enum OfferingType: String, Decodable {
    case exhibition = "EXHIBITION"
    case venue = "VENUE"
}

extension VenueAndExibition { var urlForImage: String { return image } }
