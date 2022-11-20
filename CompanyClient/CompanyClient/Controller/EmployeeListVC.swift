//
//  EmployeeListVC.swift
//  CompanyClient
//
//  Created by Tolga Kağan Aysu on 15.11.2022.
//

import UIKit

final class EmployeeListVC: UIViewController {

    @IBOutlet private weak var employeeTableView: UITableView! {
        didSet{
            employeeTableView.delegate = self
            employeeTableView.dataSource = self
        }
    }
    var myCompany: Company?
    var emmloyeesToShow: [EmployeeProtocol] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard myCompany != nil else { return }
        
     
        
        // register EmployeeListCell
       employeeTableView.register(UINib(nibName: "EmployeeListCell", bundle: nil), forCellReuseIdentifier: "EmployeeItemCell")
        
        emmloyeesToShow = myCompany!.employees
        
        // set UISearchController()
        setSearchBar()
        
      
        
    }
}

extension EmployeeListVC: UISearchResultsUpdating {
    func setSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Type something to search"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.automaticallyShowsCancelButton = true


        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        emmloyeesToShow = myCompany!.employees.filter { $0.name.uppercased().hasPrefix(text.uppercased())}
        if text == "" {
            emmloyeesToShow = myCompany!.employees
        }
        employeeTableView.reloadData()
        
    }
    
    
}

extension EmployeeListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emmloyeesToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeItemCell", for: indexPath) as? EmployeeListCell else { return  UITableViewCell() }
        let employee = emmloyeesToShow[indexPath.row]
        cell.configure(model: employee)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
}
