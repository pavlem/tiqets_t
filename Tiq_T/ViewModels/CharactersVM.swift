
import Foundation

class CharactersVM: ObservableObject {
    
    // MARK: - API
    @Published var characters = [Character]()
    @Published var isLoading = true
    @Published var isSearchMode = false

    func loadMore() {
        pageNumber += 1
        loadData()
    }
    
    func clearAll() {
        self.characters.removeAll()
    }
    
    func resetAll() {
        self.characters = self.originalCharacters
        self.isSearchMode = false
    }
        
    // MARK: - Properties
    var originalCharacters = [Character]()

    private var pageNumber = 1
    private var dataTask: URLSessionDataTask?
    private let networkService = StarWarsService()
    
    // MARK: - Inits
    init() { loadData() }
    deinit { dataTask?.cancel() }
    
    // MARK: - Helper
    private func loadData() {
        
        dataTask = networkService.fetchCharacters(charaterRequest: CharaterRequest(page: pageNumber), completion: { result in
            switch result {
            case .success(let characters):
                if let characters = characters {
                    DispatchQueue.main.async {
                        self.characters += characters.results
                        self.originalCharacters = self.characters
                        self.isLoading = false
                    }
                }
            case .failure(_):
                // TODO: - handle error
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        })
    }
}
