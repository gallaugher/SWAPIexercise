//
//  PersonData.swift
//  StarWars
//
//  Created by John Gallaugher on 4/5/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PersonData {
    var name = ""
    var height = ""
    var mass = ""
    var birthYear = ""
    var gender = ""
    var homeworld = ""
    var films = [String]()
    var species = [String]()
    
    
    func getPersonData(personNum: Int, completed: @escaping () -> ()) {
        
        let URL = "https://swapi.co/api/people/" + String(personNum) + "/"
        
        Alamofire.request(URL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.name = json["name"].stringValue
                self.height = json["height"].stringValue
                self.mass = json["mass"].stringValue
                self.birthYear = json["birth_year"].stringValue
                self.gender = json["gender"].stringValue
                self.homeworld = json["homeworld"].stringValue
                
                let speciesArray = json["species"]
                for index in 0...speciesArray.count - 1 {
                    self.species.append(speciesArray[index].stringValue)
                }
                
                let filmsArray = json["films"]
                for index in 0...filmsArray.count - 1 {
                    self.films.append(filmsArray[index].stringValue)
                }
                
            case .failure(let error):
                print("*** Oh no, there was an error: Error code = \(error)")
            }
            completed()
        }
    }
    
    func getHomeworld(completed: @escaping() -> ()) {
        self.homeworld = self.homeworld.replacingOccurrences(of: "http://", with: "https://")
        Alamofire.request(self.homeworld).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.homeworld = json["name"].stringValue
            case .failure(let error):
                print("%%% Oh no, there was an error accessing homeworld: Error code = \(error)")
            }
            completed()
        }
    }
    
    func getSpecies(index: Int, completed: @escaping() -> ()) {
        self.species[index] = self.species[index].replacingOccurrences(of: "http://", with: "https://")
        Alamofire.request(self.species[index]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.species[index]  = json["name"].stringValue
            case .failure(let error):
                print("%%% Oh no, there was an error accessing species: Error code = \(error)")
            }
            completed()
        }
    }
    
    func getFilms(index: Int, completed: @escaping() -> ()) {
        self.films[index] = self.films[index].replacingOccurrences(of: "http://", with: "https://")
        Alamofire.request(self.films[index]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.films[index]  = json["title"].stringValue
            case .failure(let error):
                print("%%% Oh no, there was an error accessing species: Error code = \(error)")
            }
            completed()
        }
    }
}
