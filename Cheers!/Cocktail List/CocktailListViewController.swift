//
//  CocktailListViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/5/22.
//

import UIKit
import FirebaseAuth

class CocktailListViewController: UIViewController, UITextFieldDelegate {
    
    
    var viewModel: CocktailListViewModel!
    var cocktailList: [Cocktail] = []
    var topLevelDictionary: TopLevelDictionary?

    @IBOutlet weak var homeSegmentedControl: UISegmentedControl!
     
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var cocktailListTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CocktailListViewModel(delegate: self)
        viewModel.loadData()
        tableView.dataSource = self
       
        searchBar.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
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
            homeSegmentedControl.titleForSegment(at: 0) 
            viewModel.fetchPopularApiCocktailList()
        case 1:
            homeSegmentedControl.titleForSegment(at: 1)
            viewModel.fetchFullApiCocktailList()
        case 2:
            homeSegmentedControl.titleForSegment(at: 2)
            viewModel.fetchCustomCocktailList()
        default:
            break
        }
    }
    
    // need to discover if they have signed in using sign in with apple or firebase.
    @IBAction func logoutButtonTapped(_ sender: Any) {
        viewModel.logout()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginView")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewController: loginViewController)
    }
}// End of class

extension CocktailListViewController: UITableViewDataSource {
   
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch homeSegmentedControl.selectedSegmentIndex {
        case 2:
            return viewModel.customCocktails.count
        default:
            return viewModel.standardCocktails.count
        }
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as? CocktailListTableViewCell else { return UITableViewCell() }
        
       //depending on what segment the user is on I want to display the correct tableview list.
      
       let drink = viewModel.standardCocktails[indexPath.row]
       // update the updateViews function to "configureWith" then pass in whatever cocktail list is currently indexed on the segmented control ... ie "standardCocktail" or "customCocktail"
       cell.updateViews(with: drink)
       return cell
    }
} //  end of extension

extension CocktailListViewController: CocktailListViewModelDelegate {
    func cocktailsLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
} //  end of extension

extension CocktailListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCocktail(with: searchText)
    }
}
