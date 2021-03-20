//
//  DetailPresenter.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import Foundation

protocol DetailViewProtocol: class {
    func success()
}

protocol DetailViewPresenterProtocol: class{
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?)
    var historicalData: [DayInfo]? {get set}
    var stock: StockInfo? {get set}
    func viewDidLoad(_ view: DetailViewProtocol)
    
}

class DetailPresenter: DetailViewPresenterProtocol {
    func viewDidLoad(_ view: DetailViewProtocol) {
        loadHistoricalData(stock: stock)
    }
    
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var stock: StockInfo?
    var historicalData: [DayInfo]?
    
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?) {
        self.view = view
        self.networkService = networkService
        self.stock = stock
    }

    func loadHistoricalData(stock: StockInfo?){
        guard let symbol = stock?.symbol else{
            return
        }
        networkService.getHistoricalData(for: symbol) { (result) in
            switch result{
            case .success(let info):
                self.historicalData = info
                self.view?.success()
            case .failure(let error):
                print(error)
        }
        }
        
    }
    //public 
    
    
}
