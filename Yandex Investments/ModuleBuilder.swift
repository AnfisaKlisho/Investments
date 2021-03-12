//
//  ModuleBuilder.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

protocol Builder{
    static func createMainModule() -> UIViewController
}


class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let networkService = NetworkService()
        let viewController = UIStoryboard(name: "MainModule", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let presenter = MainPresenter(view: viewController, networkService: networkService)
        viewController.presenter = presenter
        return viewController
    }
    
    
}
