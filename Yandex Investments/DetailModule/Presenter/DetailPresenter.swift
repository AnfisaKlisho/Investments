//
//  DetailPresenter.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import Foundation

protocol DetailViewProtocol: class {
    //func drawChart()
}

protocol DetailViewPresenterProtocol: class{
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?, historicalData: [DayInfo]?)
    var historicalData: [DayInfo]? {get set}
}

class DetailPresenter: DetailViewPresenterProtocol{
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol?
    var stock: StockInfo?
    var historicalData: [DayInfo]?
    
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?, historicalData: [DayInfo]?) {
        self.view = view
        self.networkService = networkService
        self.stock = stock
        self.historicalData = historicalData
    }
    
    //public 
    
    
}
