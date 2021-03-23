//
//  MainViewPresenterProtocol.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import Foundation

protocol MainViewPresenterProtocol: class{
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    
    var stocksInfo: [StockInfo]? { get set}
    var stocks: [StockInfo]? {get set}
    var favourites: [StockInfo] {get set}
    func getStocksInfo()
    func viewDidLoad(_ view: MainViewProtocol)
    func showFavourites()
    func showStocks()
    func didTapOnStock(at index: Int)
    func getLogoUrl(at index: Int)
    func cellDidPressFavouriteButton(_ index: Int)
    func getStockInfoForCell(at index: Int) -> StockInfo
    func loadSearchResults(for query: String)
}
