//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Javid Poornasir on 3/21/16.
//  Copyright © 2016 Javid Poornasir. All rights reserved.
//

import UIKit

final class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    // MARK: - SETUP
    
    private func setup() {
        nameLbl.text = pokemon.name.capitalized
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    
    
    // MARK: - ACTIONS
    
    private func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        pokedexLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        baseAttack.text = pokemon.attack
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            if pokemon.nextEvolutionLvl != "" {
                str += " - Level - \(pokemon.nextEvolutionLvl)"
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
