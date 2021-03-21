//
//  ChartPresenter.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import Foundation
import Charts

protocol ChartViewProtocol: class {
    func success()
}

protocol ChartViewPresenterProtocol: class{
    init(view: ChartViewProtocol, stock: StockInfo?, historicalData: [DayInfo]?)
    var historicalData: [DayInfo]? {get set}
    var stock: StockInfo? {get set}
    //func viewDidLoad(_ view: ChartViewProtocol)
    func getArrayWithCoordinates() -> [ChartDataEntry]
}

class ChartPresenter: ChartViewPresenterProtocol {
    
//    func viewDidLoad(_ view: ChartViewProtocol) {
//        loadHistoricalData(stock: stock)
//    }
//
    weak var view: ChartViewProtocol?
    //let networkService: NetworkServiceProtocol!
    var stock: StockInfo?
    var historicalData: [DayInfo]?
    
    
    required init(view: ChartViewProtocol, stock: StockInfo?, historicalData: [DayInfo]?) {
        self.view = view
        //self.networkService = networkService
        self.stock = stock
        self.historicalData = historicalData
    }

//    func loadHistoricalData(stock: StockInfo?){
//        guard let symbol = stock?.symbol else{
//            return
//        }
//        networkService.getHistoricalData(for: symbol) { (result) in
//            switch result{
//            case .success(let info):
//                self.historicalData = info
//                self.view?.success()
//            case .failure(let error):
//                print(error)
//        }
//        }
//
//    }
    
    
    func getArrayWithCoordinates() -> [ChartDataEntry]{
        var yValues: [ChartDataEntry] = []
        var i = 0
        for item in historicalData!{
            yValues.append(ChartDataEntry(x: Double(i), y: item.close))
            i += 1
        }
        return yValues
    }
    
    
}
