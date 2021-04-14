//
//  BuilderProtocol.swift
//  Investments
//
//  Created by Anfisa Klisho on 29.03.2021.
//

import UIKit

protocol Builder{
    static func createMainModule() -> UIViewController
    static func createDetailModule(stock: StockInfo) -> UIViewController
    static func createChartModule(stock: StockInfo, historicalData: [DayInfo]) -> UIViewController
    static func createSummaryModule(stock: StockInfo) -> UIViewController
    static func createProfileModule(stock: StockInfo) -> UIViewController
}
