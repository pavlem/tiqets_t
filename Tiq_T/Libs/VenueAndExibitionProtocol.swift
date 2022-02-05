//
//  VenueAndExibitionProtocol.swift
//  Tiq_T
//
//  Created by Pavle Mijatovic on 6.2.22..
//

import UIKit
import NetworkProvider

protocol VenueAndExibitionProtocol {
    func getAllVenuesAndExibitions(completion: @escaping (Result<[VenueAndExibition], Error>) -> ())
    func fetch(imageWithUrl url: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) -> URLSessionDataTask?
}
