//
//  ViewController.swift
//  StarWars
//
//  Created by John Gallaugher on 4/5/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Declare empty array of Character class objects
    var characters = Characters()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        characters.getCharacters {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToPersonData" {
            let destination = segue.destination as! PersonDataViewController
            let indexPath = tableView.indexPathForSelectedRow!
            destination.personSelected = indexPath.row + 1
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = characters.names[indexPath.row]
        return cell
    }
    
}

