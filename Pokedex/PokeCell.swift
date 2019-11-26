//
//  PokeCell.swift
//  Pokedex
//
//  Created by Javid Poornasir on 3/16/16.
//  Copyright © 2016 Javid Poornasir. All rights reserved.
//

import UIKit

final class PokeCell: UICollectionViewCell {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    // MARK: - INIT
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    
    // MARK: - ACTIONS
    
    func configureCell(_ pokemon: Pokemon) {
         self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
    
}
