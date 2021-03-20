//
//  ModuleBuilder.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

protocol Builder{
    static func createMainModule() -> UIViewController
    static func createDetailModule(stock: StockInfo) -> UIViewController
}


class ModuleBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let networkService = NetworkService()
        let view = UIStoryboard(name: "MainModule", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(stock: StockInfo) -> UIViewController {
        let networkService = NetworkService()
        let view = UIStoryboard(name: "DetailModule", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let presenter = DetailPresenter(view: view, networkService: networkService, stock: stock)
        view.presenter = presenter
        return view
    }
    
    
    
}
