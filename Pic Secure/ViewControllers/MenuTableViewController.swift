//
//  MenuTableViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 30/9/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController, RevealCallerProtocol {
    //var revealDelegate : RevealCallerProtocol?
     var menuOptionsArray : Array<String>!
    override func viewDidLoad() {
        super.viewDidLoad()
     //   revealDelegate = self
        self.initArray()
        self.title = "Settings"
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = APP_BACKGROUND_COLOR
        self.navigationController?.navigationBar.backgroundColor = APP_THEAM_COLOR
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.menuOptionsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.menuOptionsArray[indexPath.row]//"Theams"

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//           let myVC = storyboard?.instantiateViewController(withIdentifier: "TheamsTableViewController") as! TheamsTableViewController
//
//        self.present(myVC, animated: true, completion: nil)
    Singleton.sharedInstance.revealDelegate?.presentTheamsViewController?()
    }

    
      func initArray()  {
         
        self.menuOptionsArray = Array()
        self.menuOptionsArray.append("Account Settings")
        self.menuOptionsArray.append("App Settings")
        self.menuOptionsArray.append("Perks")
        self.menuOptionsArray.append("About Us")
        self.menuOptionsArray.append("Theams")
        
    }

}
