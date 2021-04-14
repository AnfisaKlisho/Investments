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
    
    @IBOutlet weak var marginsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(self)
        navigationItem.title = presenter.getTicker()
       
    }
    
    func createPageController(){
    
        //MARK:-Change
        guard let stock = presenter.getStock(), let historicalData = presenter.getHistoricalData() else {
            return
        }
        
        let firstVC = ModuleBuilder.createChartModule(stock: stock, historicalData: historicalData)
        let secondVC = ModuleBuilder.createSummaryModule(stock: stock)
        let thirdVC = ModuleBuilder.createProfileModule(stock: stock)
        firstVC.title = "Chart"
        secondVC.title = "Summary"
        thirdVC.title = "Profile"

        let pagingViewController = PagingViewController(viewControllers: [
            firstVC,
            secondVC,
            thirdVC
          ])

        
        
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          pagingViewController.view.leadingAnchor.constraint(equalTo: marginsView.leadingAnchor),
          pagingViewController.view.trailingAnchor.constraint(equalTo: marginsView.trailingAnchor),
          pagingViewController.view.bottomAnchor.constraint(equalTo: marginsView.bottomAnchor),
          pagingViewController.view.topAnchor.constraint(equalTo: marginsView.topAnchor)
            
        ])
        
        pagingViewController.font = UIFont(name: "Verdana Bold", size: 14)!
        pagingViewController.selectedFont = UIFont(name: "Verdana Bold", size: 18)!
        pagingViewController.textColor = UIColor.lightGray
        pagingViewController.selectedTextColor = UIColor.black
        pagingViewController.indicatorColor = UIColor.black
    }
    
}

extension DetailViewController: DetailViewProtocol{
    
}

