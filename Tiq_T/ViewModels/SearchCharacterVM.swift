
import UIKit
import NetworkProvider

class SearchCharacterVM: ObservableObject {
    
    // MARK: - API
//    @Published var characters: Characters?
    
    let searchText = "SEARCH..."
    let enterCharacterNameText = "Enter Name"
    let padding = CGFloat(30)
    let noResultsText = "No results..."
    let typeToSearchText = "Type and search..."
    let emptyNameText = "Type something..."
    
    let generalImage = UIImage(named: "swImg")!
    let width = CGFloat(300)
    let height = CGFloat(300)
    let corner = CGFloat(30)
    let shadow = CGFloat(10)
    
    // MARK: - Properties
    private let networkService = StarWarsService()
    private var dataTask: URLSessionDataTask?
    
    func search(for name: String, completion: @escaping (Characters) -> ()) {
        
        dataTask = networkService.fetchCharacters(charaterRequest: CharaterRequest(search: name), completion: { result in
            switch result {
                
            case .success(let characters):
                if let characters = characters {
                    DispatchQueue.main.async {
//                        self.characters = characters
                        completion(characters)
                    }
                }
            case .failure(let err):
                print(err)
                // TODO: - handle error
            }
        })
    }
    
    // MARK: - Inits
    deinit { dataTask?.cancel() }
}
