//
//  CustomListViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 11/9/22.
//

import UIKit

class CustomListViewController: UIViewController {
    
    @IBOutlet weak var customSegmentedControl: UISegmentedControl!
    @IBOutlet weak var customSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CustomListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CustomListViewModel(delegate: self)
        viewModel.loadData()
        tableView.dataSource = self
    }
    
   
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "SettingsView")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCustomDetailVC" {
            if let destination = segue.destination as? CustomDetailViewController {
                if let index = tableView.indexPathForSelectedRow {
                    switch customSegmentedControl.selectedSegmentIndex {
                    case 1:
                        let cocktail = viewModel.myCocktails[index.row]
                        let customDetailViewModel = CustomDetailViewModel(delegate: destination)
                        destination.customDetailViewModel = customDetailViewModel
                        customDetailViewModel.fetchCustomCocktailDetail(with: cocktail.uuid)
                    default:
                        let cocktail = viewModel.customCocktails[index.row]
                        let customDetailViewModel = CustomDetailViewModel(delegate: destination)
                        destination.customDetailViewModel = customDetailViewModel
                        customDetailViewModel.fetchCustomCocktailDetail(with: cocktail.uuid)
                    }
                }
            }
        }
    }
    
    @IBAction func customIndexChanged(_ sender: Any) {
        switch customSegmentedControl.selectedSegmentIndex {
        case 0:
            customSegmentedControl.titleForSegment(at: 0)
            viewModel.fetchCustomCocktailList()
        case 1:
            customSegmentedControl.titleForSegment(at: 1)
            viewModel.fetchMyCocktails()
        default:
            break
        }
    }
} // end of class

extension CustomListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch customSegmentedControl.selectedSegmentIndex {
        case 1:
            return viewModel.myCocktails.count
        default:
            return viewModel.customCocktails.count
        }
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
            
            switch customSegmentedControl.selectedSegmentIndex {
            case 1:
                let customCocktail = viewModel.myCocktails[indexPath.row]
                cell.updateViews(with: customCocktail)
                return cell
                
            default:
                let customCocktail = viewModel.customCocktails[indexPath.row]
                cell.updateViews(with: customCocktail)
                return cell
            }
        }
    
} // end of extension
    
    extension CustomListViewController: CustomListViewModelDelegate {
        func customCocktailsLoadedSuccessfully() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
} // end of extension
    

