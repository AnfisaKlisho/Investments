//
//  DetailViewPresenterProtocol.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 22.03.2021.
//

import Foundation

protocol DetailViewPresenterProtocol: class{
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?)
    var historicalData: [DayInfo]? {get set}
    var stock: StockInfo? {get set}
    func viewDidLoad(_ view: DetailViewProtocol)
    func getTicker() -> String
    
}
