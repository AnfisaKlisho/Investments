//
//  ModuleBuilder.swift
//  Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit


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
    
    static func createChartModule(stock: StockInfo, historicalData: [DayInfo]) -> UIViewController{
        let view = UIStoryboard(name: "Chart", bundle: nil).instantiateViewController(identifier: "ChartViewController") as! ChartViewController
        let presenter = ChartPresenter(view: view, stock: stock, historicalData: historicalData)
        view.presenter = presenter
        return view
    }
    
    static func createSummaryModule(stock: StockInfo) -> UIViewController{
        let view = UIStoryboard(name: "Summary", bundle: nil).instantiateViewController(identifier: "SummaryTableViewController") as! SummaryTableViewController
        let networkService = NetworkService()
        let presenter = SummaryPresenter(view: view, networkService: networkService, stock: stock)
        view.presenter = presenter
        return view
        
    }
    
    static func createProfileModule(stock: StockInfo) -> UIViewController{
        let view = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "ProfileTableViewController") as! ProfileTableViewController
        let networkService = NetworkService()
        let presenter = ProfilePresenter(view: view, networkService: networkService, stock: stock)
        view.presenter = presenter
        return view
    }
    
    
    
}
