//
//  CocktailListViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit

class CocktailListViewController: UIViewController {
    
    var cocktailList: [Cocktail] = []
    var viewModel: CocktailListViewModel!

    @IBOutlet weak var homeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var cocktailListTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch the cocktail
        viewModel = CocktailListViewModel(delegate: self)
        viewModel.loadData()
        tableView.dataSource = self
    }
    
  
   
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       // will need a similar if else statement so the the correct cocktail object from the correct collection is being sent to the cocktail reciever.
//        if segue.identifier == "toDetailVC" {
//            if let destination = segue.destination as? CocktailDetailViewController {
//                if let index = tableView.indexPathForSelectedRow {
//                    let cocktail = viewModel.standardCocktails[index.row]
//                    let cocktailDetailViewModel = CocktailDetailViewModel(delegate: destination, cocktailResult: cocktail)
//                    destination.cocktailDetailViewModel = cocktailDetailViewModel
//
//                }
//            }
//        }
//    }
//
   
    @IBAction func homeIndexChanged(_ sender: Any) {
        switch homeSegmentedControl.selectedSegmentIndex {
        case 0:
            homeSegmentedControl.titleForSegment(at: 0) // this will be deleted.
            // if the user has selected this index I want to load the data from the API.
            
        case 1:
            homeSegmentedControl.titleForSegment(at: 1) // this will be deleted.
            // if the user has selected this index then I want to populate the custom cocktails from Firestore.
            
        default:
            break
        }
    }
    
}// End of class

extension CocktailListViewController: UITableViewDataSource {
   
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //depending on what segment the user is on I want to display the correct tableview list.
        // if the segmented control == index 0 then return viewModel.standardCocktails.count
        // else if the segmented control == index1 then return viewModel.customCocktails.count
        if homeSegmentedControl.selectedSegmentIndex == 0 {
            return viewModel.standardDrinks.count
        } else if homeSegmentedControl.selectedSegmentIndex == 1 {
//          return viewModel.customCocktails.count
        }
        // Im not sure if this is right
        return 0
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as? CocktailListTableViewCell else {return UITableViewCell() }
        
       //depending on what segment the user is on I want to display the correct tableview list.
       let drink = viewModel.standardDrinks[indexPath.row]
       
       cell.updateViews(with: drink)
       return cell
    }
} //  end of extension

extension CocktailListViewController: CocktailListViewModelDelegate {
    func cocktailsLoadedSuccessfully() {
        tableView.reloadData()
    }
} //  end of extension
