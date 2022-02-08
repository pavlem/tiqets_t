
import SwiftUI

class VenueAndExibitionDetailVM: ObservableObject {
    
    // MARK: - API
    var image: UIImage = UIImage(systemName: "photo")!
    @Published var isAddedToAWishlist: Bool
    
    let removeTitle = "Remove from a wishlist"
    let addTitle = "Add to a wish list"
    let title = "Info"
    let imageFrameWidth = CGFloat(300)
    let shadowRadius = CGFloat(50)
    let lineWidth = CGFloat(12)
    
    var name: String { return venueAndExibitionVM.name }
    var id: UUID { return venueAndExibitionVM.id }
    var exibitionOrVenueText: String { return venueAndExibitionVM.eventType == .venue ? "Venue" : "Exebition" }
    var infoText: String { return venueAndExibitionVM.eventType == .venue ? "rating:  \(venueAndExibitionVM.rating)" : "exibition date from \(venueAndExibitionVM.start) to \(venueAndExibitionVM.end)" }
    
    var details: String {
        return "Welcome to " + exibitionOrVenueText + " for "
        + venueAndExibitionVM.name + " with " + infoText
    }
    var cornerRadius: CGFloat { return imageFrameWidth / 2 }
    
    // MARK: - Properties
    private let venueAndExibitionVM: VenueAndExibitionCellVM
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Inits
    init(venueAndExibitionVM: VenueAndExibitionCellVM) {
        self.venueAndExibitionVM = venueAndExibitionVM
        self.isAddedToAWishlist = venueAndExibitionVM.isAddedToWish
        self.image = venueAndExibitionVM.image
    }
}
