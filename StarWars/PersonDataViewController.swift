//
//  PersonDataViewController.swift
//  StarWars
//
//  Created by John Gallaugher on 4/5/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import UIKit

class PersonDataViewController: UIViewController {
    
    var personSelected: Int?
    var person = PersonData()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var homeWorldLabel: UILabel!
    
    @IBOutlet weak var speciesView: UITextView!
    @IBOutlet weak var filmsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        person.getPersonData(personNum: personSelected!) {
            self.configureUserInterface()
            self.person.getHomeworld {
                self.homeWorldLabel.text = self.person.homeworld
            }
            
            for index in 0...self.person.species.count-1 {
                self.person.getSpecies(index: index) {
                    if index != 0 {
                        self.speciesView.text! = self.speciesView.text! + "\n"
                    }
                    self.speciesView.text! = self.speciesView.text! + self.person.species[index]
                }
            }
            
            for n in 0...self.person.films.count-1 {
                self.person.getFilms(index: n) {
                    if self.filmsView.text!.characters.count != 0 {
                        self.filmsView.text! = self.filmsView.text! + "\n"
                    }
                    self.filmsView.text! = self.filmsView.text! + self.person.films[n]
                }
            }
        }
    }
    
    func configureUserInterface() {
        nameLabel.text = person.name
        heightLabel.text = person.height
        massLabel.text = person.mass
        birthYearLabel.text = person.birthYear
        genderLabel.text = person.gender
    }
    
}
