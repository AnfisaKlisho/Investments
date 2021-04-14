//
//  MainPresenter.swift
//  Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

class MainPresenter: MainViewPresenterProtocol{
    
    weak var view: MainViewProtocol?
    
    let networkService: NetworkServiceProtocol!
    var stocksInfo: [StockInfo]?
    var favourites: [StockInfo]?
    var stocks: [StockInfo]?
    var historicalData: [DayInfo]?
    var searchStocks: [StockInfo] = []
    
    let defaults = UserDefaults.standard
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func viewDidLoad(_ view: MainViewProtocol) {
       
        configureFavourites()
        getStocksInfo()
    }
    
    //MARK:-Configure Favourites
    func configureFavourites(){
        favourites = [StockInfo]()
        if let savedList = defaults.object(forKey: "favList") as? Data{
            let decoder = JSONDecoder()
            if let favList = try? decoder.decode([StockInfo].self, from: savedList){
                //favourites = favList
                for var stock in favList{
                    stock.isFavourite = true
                    favourites?.append(stock)
                }
            }
            
            
        }
    }
    
    //MARK:-Save Favourite List
    func saveFavList(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favourites) {
            defaults.set(encoded, forKey: "favList")
        }
    }
    
    //MARK:- Get Stocks info
    func getStocksInfo() {
        networkService.getListOfCompanies(20) { [weak self] (result) in
            guard let self = self else{
                return
            }
            switch result{
            case .success(let stocksInfo):
                self.stocks = self.detectFavourites(stocks: stocksInfo)
                self.stocksInfo = self.stocks
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    //MARK:- Get logo url
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
    
    //MARK:- Get logo image
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
    
    //MARK:-Show favourite list
    func showFavourites(){
        stocksInfo = favourites
        self.view?.success()
    }
    
    //MARK:-Show all stocks list
    func showStocks(){
        stocksInfo = stocks
        self.view?.success()
    }
    
    //MARK:-Did tap on stock
    func didTapOnStock(at index: Int){
        guard let stock = stocksInfo?[index] else {
            return
        }
        self.view?.showDetailedVC(stock: stock)
         
            }
    
    //MARK:- Cell did press favourite button
    func cellDidPressFavouriteButton(_ index: Int){
        guard var stock = stocksInfo?[index] else {
            return
        }
        if !stock.isFavourite{
            stock.isFavourite = true
            favourites?.append(stock)
            //let stockIndex = stocks?.firstIndex(of: stock)
            if let stockIndex = stocks?.firstIndex(where: {$0.symbol == stock.symbol}){
                stocks?[stockIndex].isFavourite = true
            }
            
            //stocks?[index].isFavourite = true
            stocksInfo?[index].isFavourite = true
            saveFavList()
            view?.updateRow(at: index)
    }
        else{
            guard let favIndex = favourites?.firstIndex(of: stock) else {return}
            favourites?.remove(at: favIndex)
            guard let stockIndex = stocks?.firstIndex(of: stock) else {
                return
            }
            stock.isFavourite = false
            stocks?[stockIndex].isFavourite = false
            stocksInfo?[index].isFavourite = false
            saveFavList()
            view?.updateRow(at: index)
        }
    
    
}
    
    //MARK:-Get stock info for cell
    func getStockInfoForCell(at index: Int) -> StockInfo?{
        return stocksInfo?[index]
    }
    
    //MARK:-Load Search Results
    func loadSearchResults(for query: String){
        searchStocks = []
        networkService.getResultFromKeywords(for: query) { (result) in
            self.searchStocks = result
            self.stocksInfo = self.searchStocks
            self.view?.success()
            }
        
        }
    
    func searchBarCancelButtonClicked(){
        stocksInfo = stocks
        view?.success()
    }
    
    
    func detectFavourites(stocks: [StockInfo]) -> [StockInfo]{
        var correctStocks = [StockInfo] ()
        for stock in stocks{
            if var st = favourites?.first(where: {$0.symbol == stock.symbol}){
                st.isFavourite = true
                correctStocks.append(st)
            }
            else{
                correctStocks.append(stock)
            }
        }
        return correctStocks
    }
    
}
    

    

