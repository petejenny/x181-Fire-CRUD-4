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
    
    //var myDesserts = [String]()
    var users = [User]()
    
    @IBAction func onAddTapped(_ sender: UIBarButtonItem) {
        
        AlertService.addUser(in: self) { user in
            print("Added User: \(user)")
            self.users.append(user)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //tableView.dataSource = x
        
        MyFireService.shared.create()
        
        //FirestoreDbService.shared.update()

        //MyFireService.shared.delete()
    }
    

}

extension ViewController: UITableViewDataSource {
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // Cell for row at index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Get cell at IndexPath.row==\(indexPath.row)")
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier:nil)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = String(user.age)
        
        return cell
    }
  
    // Edit cell
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        AlertService.updateUser(in: self) {
//
//        }
//    }
    
    // Delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        users.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
