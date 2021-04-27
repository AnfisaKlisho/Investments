//
//  SummaryViewPresenterProtocol.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 22.03.2021.
//

import Foundation

protocol SummaryViewPresenterProtocol{
    init(view: SummaryViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?)
    var stock: StockInfo? {get set}
    var quote: Quote? { get set }
    func loadQuote()
    func getQuote() -> Quote?
}

