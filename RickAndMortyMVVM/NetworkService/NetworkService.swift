//
//  NetworkService.swift
//  MVVMDeneme
//
//  Created by Kadirhan Keles on 31.07.2023.
//

import Foundation

protocol NetworkServiceInterface {
    func fetchAllDatas(completion: @escaping(Result<[Character], NetworkError>) -> Void)
}

enum RickAndMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        print("\(BASE_URL.rawValue)\(PATH.rawValue)")
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

class NetworkService: NetworkServiceInterface {
    func fetchAllDatas(completion: @escaping(Result<[Character], NetworkError>) -> Void) {
        let urlString = RickAndMortyServiceEndPoint.characterPath()
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil,
               let data = data,
               let resultData = try? JSONDecoder().decode(RickAndMortyModel.self, from: data) {
                completion(.success(resultData.results!))
            }else {
                completion(.failure(.canNotParseData))
            }
               
        }.resume()
    }
}
