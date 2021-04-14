//
//  ChartPresenter.swift
//  Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import Foundation
import Charts

class ChartPresenter: ChartViewPresenterProtocol {

    weak var view: ChartViewProtocol?
    var stock: StockInfo?
    var historicalData: [DayInfo]?
    
    
    required init(view: ChartViewProtocol, stock: StockInfo?, historicalData: [DayInfo]?) {
        self.view = view
        self.stock = stock
        self.historicalData = historicalData
    }

    
    
    func getArrayWithCoordinates() -> [ChartDataEntry]{
        var yValues: [ChartDataEntry] = []
        var i = 0
        for item in historicalData!{
            yValues.append(ChartDataEntry(x: Double(i), y: item.close))
            i += 1
        }
        return yValues
    }
    
    func getPrice() -> String{
        guard let price = stock?.latestPrice else {
            return ""
        }
        return "$\(price)"
    }
    
    func getChangePrice() -> String{
        guard let change = stock?.changePercent else {
            return ""
        }
        return "$\(stock!.change) ($\(round(change * 100) / 100)%)"
    }
    
    func isChangePositive() -> Bool{
        guard let change = stock?.changePercent else {
            return false
        }
        if change > 0 {
            return true
        }
        else{
            return false
        }
    }
    
    
}
