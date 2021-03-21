//
//  SummaryTableViewController.swift
//  Yandex Investments
//
//  Created by Anfisa Klisho on 21.03.2021.
//

import UIKit

class SummaryTableViewController: UITableViewController {
    
    var presenter: SummaryViewPresenterProtocol!
    
    @IBOutlet weak var previousCloseLabel: UILabel!

    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var volumeLabel: UILabel!
    
    @IBOutlet weak var marketCapLabel: UILabel!
    
    @IBOutlet weak var peLabel: UILabel!
    
    @IBOutlet weak var wkRangeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadQuote()
        //setUpTableView()
    }
    
    func setUpTableView(){
        let quote = presenter.getQuote()
        wkRangeLabel.text = "\(checkIfNull(number: quote.week52Low))-\(checkIfNull(number: quote.week52High))"
        previousCloseLabel.text = checkIfNull(number: quote.previousClose)
        openLabel.text = checkIfNull(number: quote.open)
        marketCapLabel.text = checkIfNull(number: quote.marketCap)
        peLabel.text = checkIfNull(number: quote.peRatio)
        volumeLabel.text = checkIfNull(number: quote.volume)
    }
    
    func checkIfNull(number: Double?) -> String{
        if number != nil{
            return "\(number!)"
        }
        else{
            return "N/A"
        }
    }

}

extension SummaryTableViewController: SummaryViewProtocol{
    func success() {
        setUpTableView()
        //tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
        showAlert(error)
    }
    
    
}
