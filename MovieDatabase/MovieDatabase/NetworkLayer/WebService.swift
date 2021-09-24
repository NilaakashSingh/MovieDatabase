//
//  WebService.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 24/09/21.
//

import Alamofire
import Foundation
import ObjectMapper

class WebService {
    static func request<T: Mappable>(url: URL, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let castableValue = value as? [String: Any] else { return }
                guard let data = Mapper<T>().map(JSON: castableValue) else { return }
                completion(.success(data))
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
