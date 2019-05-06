//
//  ViewController.swift
//  x181 Fire CRUD 4
//
//  Created by Peter Forward on 5/4/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myDesserts = [String]()
    
    @IBAction func onAddTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Dessert", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (dessertTF) in
            dessertTF.placeholder = "Enter Dessert"
        }
        
        let action = UIAlertAction(title: "add", style: .default) { (_) in
            guard let dessert = alert.textFields?.first?.text else { return }
            print(dessert)
            self.add(dessert)
            
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //tableView.dataSource = x
    }
    
    func add(_ dessert: String) {
        print("Add dessert=\(dessert)")
        let index = 0
        
        // Add value to array
        myDesserts.insert(dessert, at: index)
        print("desserts size=\(myDesserts.count)")
        
        // Insert new row
        let indexPath = IndexPath(row: index, section: 0)
        //tableView.beginUpdates()
        print("InsertRows")
        //tableView.reloadData()
        tableView.insertRows(at: [indexPath], with: .left)
        //tableView.insertRows(at: [IndexPath(row: desserts.count-1, section: 0)], with: .left)
        
        //tableView.endUpdates()
        
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDesserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Get cell at IndexPath.row==\(indexPath.row)")
        let cell = UITableViewCell()
        let dessert = myDesserts[indexPath.row]
        cell.textLabel?.text = dessert
        return cell
        
        /*
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeue cell is not an instancer of MealTableViewCell.")
        }
        
        // Fetches the appropiate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
        */
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        myDesserts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
