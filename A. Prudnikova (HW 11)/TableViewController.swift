//
//  TableViewController.swift
//  A. Prudnikova (HW 11)
//
//  Created by Ann Prudnikova on 23.11.22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfStudentTableViewCell", for: indexPath) as? ListOfStudentTableViewCell {
            
            let student = students[indexPath.row]
            cell.refresh(student)
            
            return cell
        }
        return UITableViewCell()
    }
    
    

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
