//
//  CustomListViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 11/9/22.
//

import UIKit

class CustomListViewController: UIViewController {

    @IBOutlet weak var customSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CustomListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CustomListViewModel(delegate: self)
        tableView.dataSource = self
        viewModel.fetchMyCustomCocktails()
    }
    
    
    // MARK: - Navigation - segue to the CustomDetailView

}

extension CustomListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch customSegmentedControl.selectedSegmentIndex {
        case 1:
            return viewModel.customCocktails.count
        default:
            // MARK: - need a specific users custom creations here. Not the full list.
            return viewModel.customCocktails.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        
        let customCocktail = viewModel.customCocktails[indexPath.row]
        
        cell.updateViews(with: customCocktail)
        return cell
    }
}

extension CustomListViewController: CustomListViewModelDelegate {
    func customCocktailsLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
