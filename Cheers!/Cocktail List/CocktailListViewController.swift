//
//  CocktailListViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit

class CocktailListViewController: UIViewController {

    @IBOutlet weak var homeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var cocktailListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
  
  
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        }
     
    // This needs to be reviewed.
    @IBAction func homeIndexChanged(_ sender: Any) {
        switch homeSegmentedControl.selectedSegmentIndex {
        case 0:
            homeSegmentedControl.titleForSegment(at: 0) // this will be deleted.
            // if the user has selected this index I want to load the data from the API.
        case 1:
            homeSegmentedControl.titleForSegment(at: 1) // this will be deleted.
            // if the user has selected this index then I want to populate the custom cocktails.
        default:
            break
        }
    }
    
}// End of class

extension CocktailListViewController: UITableViewDataSource {
   
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //depending on what segment the user is on I want to display the correct tableview list.
        return CocktailListViewModel.customCocktails.count
    }
    
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as? CocktailListTableViewCell else {return UITableViewCell() }
        
       //depending on what segment the user is on I want to display the correct tableview list.
       let cocktail = CocktailListViewModel.customCocktails[indexPath.row]
        cell.updateView(for: cocktail)
        return cell
    }
}
