//
//  VenueAndExibitionLocal.swift
//  Tiq_T
//
//  Created by Pavle Mijatovic on 6.2.22..
//

import UIKit
import NetworkProvider

class VenueAndExibitionLocal: VenueAndExibitionProtocol {
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
    
    func getAllVenuesAndExibitions(completion: @escaping (Result<[VenueAndExibition], Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let path = Bundle.main.path(forResource: "offerings", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let venuesAndExibitions = try! jsonDecoder.decode(Offerings.self, from: data)
            completion(.success(venuesAndExibitions.items))
        }
    }
}
