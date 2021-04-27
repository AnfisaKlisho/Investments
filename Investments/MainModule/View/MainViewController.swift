//
//  MainViewController.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 10.03.2021.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var stocksButton: UIButton!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter.viewDidLoad(self)
    }
    
    //MARK:-Configure
    func configure(){
        tableView.delegate = self
        tableView.dataSource = self

        setupSearchController()
        setupButtons()
    }
    
    
    //MARK:-Setup Search Controller
    private func setupSearchController(){
        let searchC = UISearchController(searchResultsController: nil)
        searchC.searchBar.placeholder = "Find company or ticker"
        searchC.searchBar.returnKeyType = .search
        searchC.searchBar.delegate = self
        searchC.obscuresBackgroundDuringPresentation = false
        searchC.searchBar.autocorrectionType = .yes
        navigationItem.searchController = searchC
    }
    
    //MARK:- SetUp buttons
    private func setupButtons(){
        stocksButton.setTitleColor(.black, for: .selected)
        stocksButton.setTitleColor(.lightGray, for: .normal)
        favouriteButton.setTitleColor(.black, for: .selected)
        favouriteButton.setTitleColor(.lightGray, for: .normal)
        stocksButton.isSelected = true
        
    }
    
    //MARK:-Stocks button clicked
    @IBAction func stocksButtonClicked(_ sender: Any) {
        setHightlightedState(for: stocksButton)
        setNormalState(for: favouriteButton)
        presenter.showStocks()
    }
  
    //MARK:-Favourite button clicked
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
    
    //MARK:-Show detailed view controller
    func showDetailedVC(stock: StockInfo){
        let detailViewController = ModuleBuilder.createDetailModule(stock: stock)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

//MARK:-DataSource & Delegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.stocksInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockViewCell.identifier, for: indexPath) as? StockViewCell else{
            fatalError("Invalid view cell")
        }
        
       
        guard let stockInfo = presenter.getStockInfoForCell(at: indexPath.row) else{
            return cell
        }
        cell.configure(with: stockInfo, at: indexPath.row)
        presenter.getLogoUrl(at: indexPath.row)
        cell.delegate = self
        let imageName = stockInfo.isFavourite ? "yellowStar" : "greyStar"
        cell.starButton.setImage(UIImage(named: imageName), for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
        
    }
    
    
    
}

extension MainViewController: MainViewProtocol{
    
    //MARK:- Success (table view reload data)
    func success() {
        tableView.reloadData()
    }
    
    //MARK:- Failure (show alert)
    func failure(error: Error) {
        print(error.localizedDescription)
        showAlert(error)
    }
    
    
    //MARK:- Set image for cell
    func setImage(_ image: UIImage, at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? StockViewCell else {
            return
        }
        
        cell.configureImage(with: image)
        
    }
    
  
    //MARK:-Update Row
    func updateRow(at index: Int){
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .fade)

    }
     
    
}
//MARK:-Did Select Row At
extension MainViewController{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapOnStock(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- StockViewCell Delegate
extension MainViewController: StockViewCellDelegate{
    
    func cellDidPressFavouriteButton(_ cell: StockViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        presenter.cellDidPressFavouriteButton(indexPath.row)

    }
    
    func cellDidLayoutSubviews(_ cell: StockViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        guard let stockInfo = presenter.getStockInfoForCell(at: indexPath.row) else{
            return
        }
        cell.starButton.imageView?.tintColor = stockInfo.isFavourite ? UIColor.systemYellow : .lightGray
    }
    


}

//MARK:-UISearchBatDelegate
extension MainViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else{
            return}
        presenter.loadSearchResults(for: query)
        
    
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarCancelButtonClicked()
    }
}

