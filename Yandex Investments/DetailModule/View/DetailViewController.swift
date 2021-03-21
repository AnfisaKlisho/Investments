//
//  DetailViewController.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 18.03.2021.
//

import UIKit
import Parchment

class DetailViewController: UIViewController {
    
    var presenter: DetailViewPresenterProtocol!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(self)
        //presenter.viewDidLoad(self)
       //createPageController()
       
    }
    
    func createPageController(){
        let firstVC = ModuleBuilder.createChartModule(stock: presenter.stock!, historicalData: presenter.historicalData!)
        let secondVC = ModuleBuilder.createSummaryModule(stock: presenter.stock!)
        
        let pagingViewController = PagingViewController(viewControllers: [
            firstVC,
            secondVC
          ])
        
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
}

extension DetailViewController: DetailViewProtocol{
    
}

