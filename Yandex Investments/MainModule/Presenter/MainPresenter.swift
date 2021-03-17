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
}

protocol MainViewPresenterProtocol: class{
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getStocksInfo()
    var stocksInfo: [StockInfo]? { get set}
    func getImageUrls()
    var images: [UIImage]? {get set}
    func loadImagesFromUrls()
    var imageUrls: [String]? {get set}
    var favourites: [StockInfo] {get set}
    var stocks: [StockInfo]? {get set}
    func showFavourites()
    func showStocks()
}

class MainPresenter: MainViewPresenterProtocol{
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var stocksInfo: [StockInfo]?
    var images: [UIImage]?
    var imageUrls: [String]?
    var favourites: [StockInfo] = []
    var stocks: [StockInfo]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getStocksInfo()
        //getImageUrls()
        //loadImagesFromUrls()
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
                //self.view?.success()
                //self.getImageUrls()
                //self.loadImagesFromUrls()
                //self.getImageUrls()
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func getImageUrls(){
        for stock in stocksInfo!{
            networkService.getLogoUrl(for: stock.symbol) { (result) in
                switch result{
                case .success(let imageInfo):
                    self.imageUrls?.append(imageInfo.url)
                    //self.loadImagesFromUrls()
                case .failure(let error):
                    print(error)
        }
        
            }
        }
    }
    
    
    func loadImagesFromUrls(){
        for url in imageUrls!{
            networkService.getLogoImage(for: url) { (result) in
                switch result{
                case .success(let image):
                    self.images?.append(image)
                    self.view?.success()
                case .failure(let error):
                    //self.images?.append(UIImage(named: "color-light-gray")!)
                    print(error)
                }
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
    
    func addToFavourites(){
        
    }
    
    
    
    
}
