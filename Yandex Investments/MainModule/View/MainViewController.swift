//
//  MainViewController.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {

    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var stocksButton: UIButton!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        tableView.delegate = self
        tableView.dataSource = self
        setupSearchController()
        setupButtons()
        //presenter.getImageUrls()
    }
    
    private func setupSearchController(){
        let searchC = UISearchController(searchResultsController: nil)
        searchC.searchBar.placeholder = "Find company or ticker"
        searchC.searchBar.returnKeyType = .search
        searchC.searchBar.delegate = self
        searchC.obscuresBackgroundDuringPresentation = false
        searchC.searchBar.autocorrectionType = .yes
        navigationItem.searchController = searchC
    }
    
    private func setupButtons(){
        stocksButton.setTitleColor(.black, for: .selected)
        stocksButton.setTitleColor(.lightGray, for: .normal)
        favouriteButton.setTitleColor(.black, for: .selected)
        favouriteButton.setTitleColor(.lightGray, for: .normal)
        stocksButton.isSelected = true
        
    }
    
    @IBAction func stocksButtonClicked(_ sender: Any) {
        setHightlightedState(for: stocksButton)
        setNormalState(for: favouriteButton)
        
    }
  
    @IBAction func favouriteButtonClicked(_ sender: Any) {
        setHightlightedState(for: favouriteButton)
        setNormalState(for: stocksButton)
        presenter.showFavourites()
    }
    
    private func setHightlightedState(for button: UIButton){
        button.isSelected = true
        button.titleLabel?.textColor = UIColor.black
        button.titleLabel?.font = UIFont(name: "Verdana Bold", size: 28)
        presenter.showStocks()
    }
    
    private func setNormalState(for button: UIButton){
        button.isSelected = false
        button.titleLabel?.textColor = UIColor.lightGray
        button.titleLabel?.font = UIFont(name: "Verdana Bold", size: 18)
    }
    
    func showDetailedVC(stock: StockInfo, data: [DayInfo]){
        let detailViewController = ModuleBuilder.createDetailModule(stock: stock, historicalData: data)
        navigationController?.pushViewController(detailViewController, animated: true)
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
        let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
     
    
}

extension MainViewController{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let stock = presenter.stocksInfo?[indexPath.row]
        //navigationController?.pushViewController(detailViewController, animated: true)
        presenter.didTapOnStock(stock: stock!)
    }
}

