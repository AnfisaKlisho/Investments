//
//  SummaryPresenter.swift
//  Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import Foundation

class SummaryPresenter: SummaryViewPresenterProtocol{
    
    weak var view: SummaryViewProtocol?
    
    let networkService: NetworkServiceProtocol!
    var stock: StockInfo?
    var quote: Quote?
    
    required init(view: SummaryViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?) {
        self.networkService = networkService
        self.view = view
        self.stock = stock
    }
    
    func loadQuote(){
        guard let symbol = stock?.symbol else{
            return
        }
        networkService.requestQuote(for: symbol) { (result) in
            switch result{
            case .success(let quote):
                self.quote = quote
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
                print(error.localizedDescription)
            }
        }
    }
    
    func getQuote() -> Quote?{
        return quote
    }
    
    
    
}
