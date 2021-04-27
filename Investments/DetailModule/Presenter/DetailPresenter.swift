//
//  DetailPresenter.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import Foundation

class DetailPresenter: DetailViewPresenterProtocol {
    func viewDidLoad(_ view: DetailViewProtocol) {
        loadHistoricalData()
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

    func loadHistoricalData(){
        guard let symbol = stock?.symbol else{
            return
        }
        networkService.getHistoricalData(for: symbol) { (result) in
            switch result{
            case .success(let info):
                self.historicalData = info
                self.view?.createPageController()
                //self.view?.success()
            case .failure(let error):
                print(error)
        }
        }
        
    }
    
    func getTicker() -> String{
        
        guard let symbol = stock?.symbol else {
            return ""
        }
        return symbol
    }
    
    func getStock() -> StockInfo?{
        return stock
    }
    
    func getHistoricalData() -> [DayInfo]?{
        return historicalData
    }
    
    

    
    
}
