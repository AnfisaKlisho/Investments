//
//  MainPresenter.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

protocol MainViewProtocol: class{
    func success()
    func failure(error: Error)
    func showDetailedVC(stock: StockInfo)
    func setImage(_ image: UIImage, at index: Int)
    func updateRow(at index: Int)
}

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
}

class MainPresenter: MainViewPresenterProtocol{
    
    weak var view: MainViewProtocol?
    
    let networkService: NetworkServiceProtocol!
    var stocksInfo: [StockInfo]?
    var favourites: [StockInfo] = []
    var stocks: [StockInfo]?
    var historicalData: [DayInfo]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func viewDidLoad(_ view: MainViewProtocol) {
        getStocksInfo()
    }
    
    func getStocksInfo() {
        networkService.getListOfCompanies(20) { [weak self] (result) in
            guard let self = self else{
                return
            }
            switch result{
            case .success(let stocksInfo):
                self.stocks = stocksInfo
                self.stocksInfo = self.stocks
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func getLogoUrl(at index: Int) {
        guard let symbol = stocksInfo?[index].symbol else{
            return
        }
        networkService.getLogoUrl(for: symbol) { (result) in
            switch result{
            case .success(let imageInfo):
                self.getLogoImage(for: imageInfo.url, at: index)
            case .failure(let error):
                print(error)
        }
    }
}
    
    func getLogoImage(for url: String, at index: Int){
        networkService.getLogoImage(for: url) { (result) in
            switch result{
            case .success(let image):
                self.view?.setImage(image, at: index)
            case .failure(let error):
                print(error)
            }
            
    }
    
    }
    
    func showFavourites(){
        stocksInfo = favourites
        self.view?.success()
    }
    
    func showStocks(){
        stocksInfo = stocks
        self.view?.success()
    }
    
    func didTapOnStock(at index: Int){
        guard let stock = stocksInfo?[index] else {
            return
        }
        self.view?.showDetailedVC(stock: stock)
         
            }
    
    func cellDidPressFavouriteButton(_ index: Int){
        guard var stock = stocksInfo?[index] else {
            return
        }
        if !stock.isFavourite{
            stock.isFavourite = true
            favourites.append(stock)
            stocks![index].isFavourite = true
            stocksInfo![index].isFavourite = true
            view?.updateRow(at: index)
    }
        else{
            guard let favIndex = favourites.firstIndex(of: stock) else {return}
            favourites.remove(at: favIndex)
            guard let stockIndex = stocks?.firstIndex(of: stock) else {
                return
            }
            stocks![stockIndex].isFavourite = false
            stocksInfo![index].isFavourite = false
            view?.updateRow(at: index)
        }
    
    
}
}
    
