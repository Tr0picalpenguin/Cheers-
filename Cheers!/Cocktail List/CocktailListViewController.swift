//
//  CocktailListViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit
import FirebaseAuth

class CocktailListViewController: UIViewController {
    
    
    var viewModel: CocktailListViewModel!

    @IBOutlet weak var homeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var cocktailListTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CocktailListViewModel(delegate: self)
        viewModel.loadData()
        tableView.dataSource = self
    }
    
  
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // will need a similar if else statement so the the correct cocktail object from the correct collection is being sent to the cocktail reciever.
        if segue.identifier == "toDetailVC" {
            if let destination = segue.destination as? CocktailDetailViewController {
                if let index = tableView.indexPathForSelectedRow {
                  
                    let cocktail = viewModel.standardCocktails[index.row]
                    let cocktailDetailViewModel = CocktailDetailViewModel(delegate: destination)
                    cocktailDetailViewModel.fetchCocktailDetail(with: cocktail.cocktailID)
                    destination.cocktailDetailViewModel = cocktailDetailViewModel

                }
            }
        }
    }

   
    @IBAction func homeIndexChanged(_ sender: Any) {
        switch homeSegmentedControl.selectedSegmentIndex {
        case 0:
            homeSegmentedControl.titleForSegment(at: 0) // this will be deleted.
            // if the user has selected this index I want to load the popular cocktail data from the API.
            
        case 1:
            homeSegmentedControl.titleForSegment(at: 1) // this will be deleted.
            // if the user has selected this index then I want to load the full list of cocktails from the Api.
        case 2:
            homeSegmentedControl.titleForSegment(at: 2)
            // if the user has selected this index then I want to populate the custom cocktails from Firestore
        default:
            break
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        viewModel.logout()
    }
    
    
}// End of class

extension CocktailListViewController: UITableViewDataSource {
   
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if homeSegmentedControl.selectedSegmentIndex == 0 {
            return viewModel.standardCocktails.count
        } else if homeSegmentedControl.selectedSegmentIndex == 1 {
//          return viewModel.customCocktails.count
        }
        // Im not sure if this is right
        return 0
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as? CocktailListTableViewCell else {return UITableViewCell() }
        
       //depending on what segment the user is on I want to display the correct tableview list.
       let drink = viewModel.standardCocktails[indexPath.row]
       
       cell.updateViews(with: drink)
       return cell
    }
} //  end of extension

extension CocktailListViewController: CocktailListViewModelDelegate {
    func cocktailsLoadedSuccessfully() {
        tableView.reloadData()
    }
} //  end of extension
