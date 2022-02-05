
import Foundation

class VenuesAndExibitionsVM: ObservableObject {
    
    // MARK: - API
    @Published var venuesAndExibitions = [VenueAndExibitionCellVM]()
    @Published var venuesAndExibitionsWishes = [VenueAndExibitionCellVM]()
    @Published var isLoading = true
    
    func addOrRemoveToWishes(uuid: UUID) {
        if let _ = venuesAndExibitionsWishes.filter({ $0.id == uuid }).first {
            venuesAndExibitionsWishes.removeAll{$0.id == uuid}
            return
        }

        guard let venueAndExibition = venuesAndExibitions.filter({ $0.id == uuid }).first else { return }
        venuesAndExibitionsWishes.append(venueAndExibition)
    }
    
    func isInAWishList(forUUID uuid: UUID) -> Bool {
        return venuesAndExibitionsWishes.filter { $0.id == uuid }.first != nil
    }

    let companyTitle = "Offerings..."
    let seeAllButtonTitle = "See All"
    let wishListButtonTitle = "Wish List"
    
    // MARK: - Properties
    private var dataTask: URLSessionDataTask?
    private let venueAndExibitionRepo: VenueAndExibitionProtocol
    
    // MARK: - Inits
    init(venueAndExibitionRepo: VenueAndExibitionProtocol) {
        
        self.venueAndExibitionRepo = venueAndExibitionRepo
        
        venueAndExibitionRepo.getAllVenuesAndExibitions { result in
            switch result {
            case .success(let venuesAndExibitions):
                DispatchQueue.main.async {
                    self.venuesAndExibitions = venuesAndExibitions.map { VenueAndExibitionCellVM(venueAndExibition: $0) }
                    self.isLoading = false
                }
            case .failure(_):
                // TODO: - handle error
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
    
    deinit { dataTask?.cancel() }
}
