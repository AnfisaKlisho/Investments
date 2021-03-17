//
//  MainViewController.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainViewPresenterProtocol!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
  

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.stocksInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockViewCell.identifier, for: indexPath) as? StockViewCell else{
            fatalError("Invalid view cell")
        }
        
        let stockInfo = presenter.stocksInfo?[indexPath.row]
        cell.configure(with: stockInfo!, at: indexPath.row)
        //presenter.loadImageFromURL(from: <#T##URL#>)
        //let image = presenter.images?[indexPath.row]
        //cell.configureImage(with: image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
        
    }
    
    
}

extension MainViewController: MainViewProtocol{
    func success() {
        tableView.reloadData()
    }
    
    //MARK:-MAKE ALERT
    func failure(error: Error) {
        print(error.localizedDescription)
    }
     

    
}

