//
//  ListDoctorsController.swift
//  test app
//
//  Created by iosnuk on 29.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit

class ListDoctorsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DoctorsService.instance.getData().count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DoctorsService.instance.getListOfDoctors {
//            self.tableView.beginUpdates()
//            self.tableView.insertRows(at: [IndexPath(row: DoctorsService.instance.getData().count-1, section: 0)], with: .automatic)
//            self.tableView.endUpdates()
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > DoctorsService.instance.getData().count - 3 {
            DoctorsService.instance.getListOfDoctors {
                //            self.tableView.beginUpdates()
                //            self.tableView.insertRows(at: [IndexPath(row: DoctorsService.instance.getData().count-1, section: 0)], with: .automatic)
                //            self.tableView.endUpdates()
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath) as! DoctorCell

        cell.setData(data: DoctorsService.instance.getData()[indexPath.row])

        return cell
    }
}
