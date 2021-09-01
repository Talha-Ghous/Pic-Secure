//
//  TheamsTableViewController.swift
//  Pic Secure
//
//  Created by Talha Ghous on 2/6/18.
//  Copyright © 2018 Talha Ghous. All rights reserved.
//

import UIKit

class TheamsTableViewController: UITableViewController {

    var theamsArray : Array<TheamsModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Theams"
         theamsArray  = TheamsModel.initTheamsArray()
        self.view.backgroundColor = APP_BACKGROUND_COLOR
        self.navigationController?.navigationBar.backgroundColor = APP_THEAM_COLOR
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneAction))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    

    @objc func doneAction(sender: AnyObject)  {
        Singleton.sharedInstance.revealDelegate?.dismissTheamsFetching?()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.theamsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TheamsTableViewCell

         cell.colorView.backgroundColor = self.theamsArray[indexPath.row].color
         cell.colorNameLable.text = self.theamsArray[indexPath.row].colorName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            APP_THEAM_COLOR = self.theamsArray[indexPath.row].color
        //    self.view.backgroundColor = APP_BACKGROUND_COLOR
            self.navigationController?.navigationBar.backgroundColor = APP_THEAM_COLOR
        
    }

}
