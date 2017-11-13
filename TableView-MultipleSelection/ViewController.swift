//
//  ViewController.swift
//  TableView-MultipleSelection
//
//  Created by Pranil on 11/13/17.
//  Copyright © 2017 pranil. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    @IBOutlet weak var viewTable: UITableView!
    
    // Declare a boolean varaible to toggle the checkbox in the first section of table view
    var isSelectAllSelected : Bool = false
    var cellData: [CellItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cellData = [CellItem(name: "Pran"), CellItem(name: "Brad"), CellItem(name: "Harry"), CellItem(name: "Modric"), CellItem(name: "Dembele")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else
        {
            return cellData.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableCell()
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "Select All"
            if isSelectAllSelected{
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
            
        }
        else
        {
            cell.textLabel?.text = cellData[indexPath.row].name
            if cellData[indexPath.row].isSelected{
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
            
        }
        return cell
    }
    
    
    // MARK: -  Table view delegates
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0
        {
            cellData[indexPath.row].isSelected = !cellData[indexPath.row].isSelected
            isSelectAllSelected = cellData[indexPath.row].isSelected
            for index in cellData.indices
            {
                cellData[index].isSelected = cellData[indexPath.row].isSelected
            }
        }
        else
        {
            cellData[indexPath.row].isSelected = !cellData[indexPath.row].isSelected
            if cellData.filter({ $0.isSelected }).count == cellData.count
            {
                isSelectAllSelected = true
            }
            else
            {
                isSelectAllSelected = false
            }
            
        }
        viewTable.reloadData()
    }

    
}

// MARK: - struct for cell item
struct CellItem {
    var name: String
    var isSelected:Bool! = false
    init(name: String) {
        self.name = name
    }
}
