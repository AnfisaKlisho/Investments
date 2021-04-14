//
//  ChartViewPresenterProtocol.swift
//  Investments
//
//  Created by Anfisa Klisho on 22.03.2021.
//

import Foundation
import Charts

protocol ChartViewPresenterProtocol: class{
    init(view: ChartViewProtocol, stock: StockInfo?, historicalData: [DayInfo]?)
    var historicalData: [DayInfo]? {get set}
    var stock: StockInfo? {get set}
    func getArrayWithCoordinates() -> [ChartDataEntry]
    func getPrice() -> String
    func getChangePrice() -> String
    func isChangePositive() -> Bool
}
