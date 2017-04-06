//
//  Character.swift
//  StarWars
//
//  Created by John Gallaugher on 4/5/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Characters {
    
    var names = [String]()
    
    func getCharacters(completed: @escaping () -> ()) {
        let URL = "https://swapi.co/api/people/"
        Alamofire.request(URL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for index in 0...json["results"].count-1 {
                    self.names.append(json["results"][index]["name"].stringValue)
                }
            case .failure(let error):
                print("*** Oh no, there was an error: Error code = \(error)")
            }
            completed()
        }
    }
}
