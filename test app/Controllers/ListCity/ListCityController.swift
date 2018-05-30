//
//  ListCityController.swift
//  test app
//
//  Created by iosnuk on 29.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ListCityController: UITableViewController {
    
    var notificationToken: NotificationToken? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.instance.escapingHandler = {
            let app = UIApplication.shared as! AppDelegate
            app.window?.rootViewController = UIStoryboard.init(name: "main", bundle: nil).instantiateViewController(withIdentifier: "speciality")
            
            app.window?.makeKeyAndVisible()
        }
        
        LocationService.instance.getListOfCityes()
        // Do any additional setup after loading the view, typically from a nib.
        notificationToken = LocationService.instance.getData().observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                break
            //            case .update(_, let deletions, let insertions, let modifications):
            case .update(_, let deletions, let insertions, let modifications):
                //                tableView.reloadData()
                //                 Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                //                tableView.reloadData()
                if insertions.count > 0 {
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                }
                if deletions.count > 0 {
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                }
                if modifications.count > 0 {
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                }
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        notificationToken?.invalidate()
        LocationService.instance.escapingHandler = nil
    }
    
}

extension ListCityController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationService.instance.getData().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        let index = indexPath.row
        
        let item = LocationService.instance.getData()[index] as CityInfo
        
        cell.setTitle(title: item.Name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        let item = LocationService.instance.getData()[index] as CityInfo
        UserDefaults.standard.setValue(item.Id, forKey: "CityID")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (self.navigationController?.viewControllers.count)! > 1{
            self.navigationController?.popViewController(animated: true)
        } else {
            LocationService.instance.escapingHandler!()
        }
    }
}
