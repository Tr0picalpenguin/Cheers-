//
//  FavoritesViewController.swift
//  Cheers!
//
//  Created by Scott Cox on 7/7/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesSegmentedControl: UISegmentedControl!
    
    var viewModel: FavoritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let alertController = UIAlertController(title: "My Creation feature coming soon!", message: "Click ok and get back to enjoying a full database of curated cocktail. Cheers!", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
        return
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesTableViewCell else {return UITableViewCell() }
//        
//       //depending on what segment the user is on I want to display the correct tableview list.
//      
//       }
//}
