
import UIKit

class CharacterVM: ObservableObject {
    
    @Published var image: UIImage = UIImage(systemName: "photo")!
    var name: String { return character.name }
    var height: String { return character.height }
    var hairColor: String { return character.hairColor ?? "No info..." }
    var birthYear: String { return character.birthYear ?? "No info..." }
    var urlForImage: String { return character.urlForImage! }
    
    let nameTitle = "Name: "
    let heightTitle = "Height: "
    let hairTitle = "Hair: "
    let birthTitle = "Birth: "
    
    var isFavorite: Bool {
        if name.lowercased().contains("lu") || name.lowercased().contains("ana") || name.lowercased().contains("vad") || name.lowercased().contains("bo") {
            return true
        }
        return false
    }
    
    // MARK: - Properties
    let character: Character
    private var dataTask: URLSessionDataTask?
    private let networkService = StarWarsService()

    // MARK: - Inits
    init(character: Character) {
        self.character = character
        fetchImage()
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

