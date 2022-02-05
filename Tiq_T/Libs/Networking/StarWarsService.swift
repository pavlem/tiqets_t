import UIKit
import NetworkProvider

class StarWarsService: NetworkService {
    
    func fetch(imageWithUrl url: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) -> URLSessionDataTask? {

        guard let url = URL(string: url) else { return nil }

        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in

            if let err = err {
                completion(.failure(NetworkError.error(err: err)))
                return
            }

            guard let data = data else {
                completion(.failure(.unknown))
                return
            }

            guard let img = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }

            completion(.success(img))
        }
        task.resume()
        return task
    }
    
    
    func fetchCharacters(charaterRequest: CharaterRequest, completion: @escaping (Result<Characters?, NetworkError>) -> ()) -> URLSessionDataTask? {
        return load(urlString: urlString, path: pathPeople, method: .get, params: charaterRequest.body(), headers: nil) { (result: Result<Characters?, NetworkError>) in
            completion(result)
        }
    }
    
    func fetchSWChars(completion: @escaping (Result<Characters?, NetworkError>) -> ()) -> URLSessionDataTask? {
        return load(urlString: urlString, path: pathPeople, method: .get, params: nil, headers: nil) { (result: Result<Characters?, NetworkError>) in
            completion(result)
        }
    }
    
    func fetchStarship(urlString: String, completion: @escaping (Result<Starship?, NetworkError>) -> ()) -> URLSessionDataTask? {
        return load(urlString: urlString, path: "", method: .get, params: nil, headers: nil) { (result: Result<Starship?, NetworkError>) in
            completion(result)
        }
    }
    
    func fetchStarships(urlStrings: [String], completion: @escaping (Result<[Starship]?, NetworkError>) -> ()) -> URLSessionDataTask? {
        var dataTask: URLSessionDataTask?
        var starShips = [Starship]()
        
        let myGroup = DispatchGroup()
        
        for url in urlStrings {
            myGroup.enter()
            dataTask = fetchStarship(urlString: url) { result in
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let sh):
                    starShips.append(sh!)
                }
                myGroup.leave()
            }
        }
        
        myGroup.notify(queue: .main) {
            completion(.success(starShips))
        }
        
        return dataTask
    }
    
    private let scheme = "https://"
    private let host = "swapi.dev/api/"
    private let pathPeople = "people"
    private let baseImageUrl = "https://starwars-visualguide.com/assets/img/characters/"
        
    private var urlString: String {
        return scheme + host
    }
}
