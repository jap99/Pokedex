//
//  ViewController.swift
//  Pokedex
//
//  Created by Javid Poornasir on 3/11/16.
//  Copyright © 2016 Javid Poornasir. All rights reserved.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private var pokemon = [Pokemon]()
    private var filteredPokemon = [Pokemon]()
    private var musicPlayer: AVAudioPlayer!
    private var inSearchMode = false
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    // MARK: - INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.returnKeyType = .done
        parsePokemonCSV()
        initAudio() 
    }
    
    
    // MARK: - SETUP
    
    private func setup() {
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
    }
    
    private func initAudio() {
        guard let path = Bundle.main.path(forResource: "music", ofType: "mp3") else { return }
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    // MARK: - ACTIONS
    
    private func parsePokemonCSV() {
        guard let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") else { return }
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
        } catch let err as NSError  {
            print(err.debugDescription)
        }
    }
    
    
    // MARK: - COLLECTION VIEW
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    // CELL FOR ITEM
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pokecell", for: indexPath) as? PokeCell {
            let poke: Pokemon!
            if inSearchMode {
                poke = filteredPokemon[(indexPath as NSIndexPath).row]
            } else {
                poke = pokemon[(indexPath as NSIndexPath).row]
            }
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // DID SELECT
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke: Pokemon!
        if inSearchMode {
            poke = filteredPokemon[(indexPath as NSIndexPath).row]
        } else {
            poke = pokemon[(indexPath as NSIndexPath).row]
        }
        print(poke.name)
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    // LAYOUT
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
    // MARK: - SEARCH BAR
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
    
    // MARK: - IBACTIONS
    
    @IBAction func musicBtnPressed(_ sender: UIButton!) {
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    
    // MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    
    
    
    
}





