//
//  HomeViewModel.swift
//  MVVMDeneme
//
//  Created by Kadirhan Keles on 31.07.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var networkService: NetworkServiceInterface? { get set}
    var characterList: [Character] {get}
    var delegate: HomeViewInterface? { get set }
    func fethAllDatas()
}

class HomeViewModel: HomeViewModelInterface {
    var delegate: HomeViewInterface?
    
    var networkService: NetworkServiceInterface? = NetworkService()
    
    var characterList: [Character] = []
    
    func fethAllDatas() {
        networkService?.fetchAllDatas(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.characterList = data
                self?.delegate?.didFetchDatas()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        })
    }
    
    
}
