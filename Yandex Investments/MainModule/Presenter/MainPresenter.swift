//
//  MainPresenter.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import Foundation

protocol MainViewProtocol: class{
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class{
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getStocksInfo()
    var stocksInfo: [StockInfo]? { get set}
}

class MainPresenter: MainViewPresenterProtocol{
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var stocksInfo: [StockInfo]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getStocksInfo()
    }
    
    func getStocksInfo() {
        networkService.getListOfCompanies(50) { [weak self] (result) in
            guard let self = self else{
                return
            }
            DispatchQueue.main.async {
                switch result{
                case .success(let stocksInfo):
                    self.stocksInfo = stocksInfo
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
            
            
        }
    }
    
    
}
