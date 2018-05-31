//
//  PropertyVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/20.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class PropertyVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PropertyVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PropertyService.instance.getProperties().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "propertyTableCell") as? PropertyCell {
            let property = PropertyService.instance.getProperties()[indexPath.row]
            
            // Set both Segue Identifier and PropertyService
            cell.updateViews(property: property)
            return cell
        }
        return PropertyCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let property = PropertyService.instance.getProperties()[indexPath.row].propertyItem
        
        performSegue(withIdentifier: property, sender: nil)
    }
}
