
import SwiftUI

class VenueAndExibitionCellVM: ObservableObject, Identifiable {
    
    // MARK: - API
    @Published var image: UIImage = UIImage(systemName: "photo")!
    @Published var isAddedToWish: Bool

    var id: UUID
    
    var type: String { return venueAndExibition.type.rawValue.lowercased().capitalized }
    var name: String { return venueAndExibition.name }
    var price: String { return venueAndExibition.price + " " + venueAndExibition.priceCurrencyCode}
    var urlForImage: String { return venueAndExibition.urlForImage }
    var start: String { return venueAndExibition.startDate ?? ""}
    var end: String { return venueAndExibition.endDate ?? "" }
    var rating: String {
        if let rating = venueAndExibition.starsRating { return String(rating) }
        return ""
    }
    var eventType: OfferingType { return venueAndExibition.type}
    
    let titleFont = Font.title3.weight(.bold)
    
    var additionalInfoTitle: String {
        if eventType == .exhibition { return "Time: " }
        return "Rating: "
    }
    
    var additionalInfo: String {
        if eventType == .exhibition { return additionalInfoTitle + start + " : " + end }
        return additionalInfoTitle + rating
    }
    
    // MARK: - Properties
    let venueAndExibition: VenueAndExibition
    private var dataTask: URLSessionDataTask?
    private let venueAndExibitionRepo: VenueAndExibitionProtocol

    // MARK: - Inits
    init(venueAndExibition: VenueAndExibition, venueAndExibitionRepo: VenueAndExibitionProtocol = VenueAndExibitionLocal()) {
        self.id = venueAndExibition.id
        self.venueAndExibition = venueAndExibition
        self.venueAndExibitionRepo = venueAndExibitionRepo
        self.isAddedToWish = false
        self.fetchImage()
    }
    
    deinit { dataTask?.cancel() }

    // MARK: - Helper
    private func cache(image: UIImage, key: String) {
        ImageHelper.shared.imageCache.setObject(image, forKey: key as NSString)
    }
    
    private func getCachedImage(imageName: String) -> UIImage? {
        if let image = ImageHelper.shared.imageCache.object(forKey: imageName as NSString) { return image }
        return nil
    }
    
    private func fetchImage() {
        if let image = getCachedImage(imageName: venueAndExibition.urlForImage) {
            self.image = image
            return
        }
        
        dataTask = venueAndExibitionRepo.fetch(imageWithUrl: venueAndExibition.urlForImage) { result in
            switch result {
            case .failure(let err):
                print(err) // TODO: - Handle error, maybe as an alert
            case .success(let img):
                DispatchQueue.main.async {
                    self.cache(image: img, key: self.venueAndExibition.urlForImage)
                    self.image = img
                }
            }
        }
    }
}

