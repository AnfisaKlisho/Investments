//
//  ProfileTableViewController.swift
//  Investments
//
//  Created by Anfisa Klisho on 22.03.2021.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    var presenter: ProfileViewPresenterProtocol!
    
   // @IBOutlet weak var descriptionLabel: UILabel!
    
 
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var sectorLabel: UILabel!
    
    //@IBOutlet weak var industryLabel: UILabel!
    
    @IBOutlet weak var employeesLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var webLabel: UILabel!
    
    @IBOutlet weak var ceoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadCompanyInfo()
        
    }
    
    func setupCompanyInfoTable(){
        guard let info = presenter.getInfo() else{
            return
        }
        if info.description == "0"{
            descriptionTextView.text = "No data"
        }
        else{
            descriptionTextView.text = checkIfNull(parameter: info.description)
        }
        
        if info.CEO == "" || info.CEO == "0"{
            ceoLabel.text = "No data"
        }
        else{
            ceoLabel.text = checkIfNull(parameter: info.CEO)
        }
        
        sectorLabel.text = checkIfNull(parameter: info.sector)
        //industryLabel.text = checkIfNull(parameter: info.industry)
        employeesLabel.text = checkIfNull(parameter: info.employees)
        addressLabel.text = checkIfNull(parameter: info.address)
        phoneLabel.text = checkIfNull(parameter: info.phone)
        webLabel.text = checkIfNull(parameter: info.website)
        //ceoLabel.text = checkIfNull(parameter: info.CEO)
    }
    
    private func checkIfNull<Object>(parameter: Object?) -> String{
        if parameter != nil{
            return "\(parameter!)"
        }
        else{
            return "N/A"
        }
    }

}

extension ProfileTableViewController: ProfileViewProtocol{
    func success() {
        setupCompanyInfoTable()
    }
    func failure(error: Error) {
        showAlert(error)
    }
    
    
}
