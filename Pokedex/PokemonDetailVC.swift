//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Javid Poornasir on 3/21/16.
//  Copyright © 2016 Javid Poornasir. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet var nameLbl: UILabel!

    var pokemon: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
