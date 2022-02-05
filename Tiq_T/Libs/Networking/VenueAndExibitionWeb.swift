import UIKit
import NetworkProvider

class VenueAndExibitionWeb: VenueAndExibitionProtocol {
    
    func fetch(imageWithUrl url: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) -> URLSessionDataTask? {
        // TODO: - Implement networking
        return nil
    }
    
    func getAllVenuesAndExibitions(completion: @escaping (Result<[VenueAndExibition], Error>) -> ()) {
        // TODO: - Implement networking
    }
    
    private let scheme = "https://"
    private let host = "museums.dev/api/" // dummy host,this needs a real value
    private let pathPeople = "venuesAndExibitions" // dummy path, this needs a real value
    
    private var urlString: String { return scheme + host }
}
