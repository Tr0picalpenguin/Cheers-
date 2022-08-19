//
//  CocktailImageView.swift
//  Cheers!
//
//  Created by Scott Cox on 7/11/22.
//

import Foundation
import UIKit

class CocktailImageView: UIImageView {

    func fetchImage(using urlString: String) {
        NetworkController.fetchImage(with: urlString) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.contentMode = .scaleAspectFit
                    self?.image = image
                }
            case .failure:
                self?.seDefaultImage()
            }
        }
    }
    func seDefaultImage() {
        contentMode = .scaleAspectFit
        self.image = UIImage(systemName: "ticket")
    }
}
