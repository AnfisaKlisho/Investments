//
//  ProfilePresenter.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 22.03.2021.
//

import Foundation

protocol ProfileViewProtocol: class{
    func success()
    func failure(error: Error)
}

protocol ProfileViewPresenterProtocol{
    init(view: ProfileViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?)
    var stock: StockInfo? {get set}
    func loadCompanyInfo()
    func getInfo() -> CompanyInfo
}

class ProfilePresenter: ProfileViewPresenterProtocol{
    
    weak var view: ProfileViewProtocol?
    
    var stock: StockInfo?
    
    let networkService: NetworkServiceProtocol!
    var companyInfo: CompanyInfo?
    
    required init(view: ProfileViewProtocol, networkService: NetworkServiceProtocol, stock: StockInfo?) {
        
        self.view = view
        self.networkService = networkService
        self.stock = stock
    }
    
    
    func loadCompanyInfo() {
        guard let symbol = stock?.symbol else {
            return
        }
        networkService.getCompanyInfo(for: symbol) { (result) in
            switch result{
            case .success(let info):
                self.companyInfo = info
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    func getInfo() -> CompanyInfo {
        
        //MARK:-Change
//        guard let info = companyInfo else {
//            return
//        }
        return companyInfo!
    }
    
    
}
