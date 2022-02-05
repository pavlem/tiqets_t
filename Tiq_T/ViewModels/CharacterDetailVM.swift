
import UIKit

class CharacterDetailVM: ObservableObject {
    
    // MARK: - API
    @Published var image: UIImage = UIImage(systemName: "photo")!
    @Published var startships: String?
    @Published var isFavorite: Bool
    
    var name: String { return character.name }
    var height: String { return character.height }
    var mass: String { return character.mass }
    var hairColor: String { return character.hairColor ?? "No info..." }
    var skinColor: String { return character.skinColor ?? "No info..." }
    var eyeColor: String { return character.eyeColor ?? "No info..." }
    var birthYear: String { return character.birthYear ?? "No info..." }
    var urlForImage: String? { return character.urlForImage }
    
    let imageFrameWidth = CGFloat(300)
    let shadowRadius = CGFloat(50)
    let lineWidth = CGFloat(12)
    let starshipsTitleText = "Starships:"
    
    let heightTitle = "Height: "
    let massTitle = "Mass: "
    let hairTitle = "Hair: "
    let skinTitle = "Skin: "
    let eyesTitle = "Eyes: "
    let birthTitle = "Birth: "
    
    var isFavoriteText: String {
        return isFavorite ? "Remove" : "Add"
    }
    
    var cornerRadius: CGFloat {
        return imageFrameWidth / 2
    }
    
    func fetchStarships() {
        dataTask = networkService.fetchStarships(urlStrings: character.starships, completion: { starships in
            switch starships {
            case .success(let shipURLs):
                DispatchQueue.main.async {
                    if let shipURLs = shipURLs {
                        let shipsDescription = self.allOFStarshipsDescription(starships: shipURLs)
                        self.startships = shipsDescription
                    }
                }
            case .failure(let err):
                print(err)
                // TODO: - Handle this error somehow...
            }
        })
    }
    
    // MARK: - Properties
    private let character: Character
    private var dataTask: URLSessionDataTask?
    private let networkService = StarWarsService()
    
    // MARK: - Inits
    init(character: Character) {
        self.character = character
        self.isFavorite = false // TODO: - Paja fix this...
        fetchImage()
    }
    
    deinit { dataTask?.cancel() }
    
    // MARK: - Helper
    private func allOFStarshipsDescription(starships: [Starship]) -> String {
        
        let allOfDescr = starships.map { $0.name + ": " + $0.model}.joined(separator: ";\n")
        
        
        
        var allOFStarships = ""
        for starShip in starships {
            allOFStarships += starShip.name + ": " + starShip.model + "\n"
        }
        return allOfDescr
    }
    
    private func cache(image: UIImage, key: String) {
        ImageHelper.shared.imageCache.setObject(image, forKey: key as NSString)
    }
    
    private func getCachedImage(imageName: String) -> UIImage? {
        if let image = ImageHelper.shared.imageCache.object(forKey: imageName as NSString) { return image }
        return nil
    }
    
    private func fetchImage() {
        if let image = getCachedImage(imageName: character.urlForImage!) {
            self.image = image
            return
        }
        
        dataTask = networkService.fetch(imageWithUrl: character.urlForImage!) { result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let img):
                DispatchQueue.main.async {
                    self.cache(image: img, key: self.character.urlForImage!)
                    self.image = img
                }
            }
        }
    }
}
