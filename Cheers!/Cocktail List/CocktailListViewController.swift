//
//  CocktailListViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit

class CocktailListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    // I need to figure out how to add a tableview onto the view controller.
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CocktailListViewModel.sharedInstance.cocktails.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as? CocktailListTableViewCell else {return UITableViewCell() }
        let cocktail = CocktailListViewModel.sharedInstance.cocktails[indexPath.row]
        cell.updateView(for: cocktail)
        return cell
    }
  
  
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        }
            

}// End of class
