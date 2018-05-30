//
//  ViewController.swift
//  test app
//
//  Created by iosnuk on 25.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ListSpecialitiesController: UITableViewController {
    
    var notificationToken: NotificationToken? = nil
    
    var groupArray:[String] = []
    var groups:[Results<SpecialityInfo>] = []
    
    var searchArray:Results<SpecialityInfo>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchDisplayController?.searchResultsTableView.separatorStyle = .none
        
        SpecialistService.instance.getListOfSpecialities()
        
        // Do any additional setup after loading the view, typically from a nib.
        notificationToken = SpecialistService.instance.getData().observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self?.initGroup()
                tableView.reloadData()
                break
//            case .update(_, let deletions, let insertions, let modifications):
            case .update(_, let deletions, let insertions, let modifications):
//                tableView.reloadData()
//                 Query results have changed, so apply them to the UITableView
                self?.initGroup()
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
    }

}

extension ListSpecialitiesController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (searchArray != nil) ? 1 : groupArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchArray != nil) ? (searchArray?.count)! : groups[section].count
//        return SpecialistService.instance.getData().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SpecialityCell", for: indexPath) as! SpecialityCell
        
        if let array = searchArray {
            let item = array[indexPath.row] as SpecialityInfo
            cell.setTitle(title: item.Name)
        } else {
            let item = groups[indexPath.section][indexPath.row] as SpecialityInfo
            cell.setTitle(title: item.Name)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var item:SpecialityInfo?
        
        if let array = searchArray {
            item = array[indexPath.row] as SpecialityInfo
        } else {
            item = groups[indexPath.section][indexPath.row] as SpecialityInfo
        }
        
        DoctorsService.instance.speciality = (item?.Id)!
        
        self.show((self.storyboard?.instantiateViewController(withIdentifier: "ListDoctorsController"))!, sender: nil)
    }
    
}

extension ListSpecialitiesController: UISearchDisplayDelegate, UISearchBarDelegate, UISearchControllerDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchArray = nil
            return
        }
        searchArray = SpecialistService.instance.getData().filter("Name CONTAINS[cd] %@", searchText)
    }
    
}

extension ListSpecialitiesController { // group
    
    func initGroup() {
        var setArray = Set<String>()
        
        groupArray = []
        groups = []
        
        for object in SpecialistService.instance.getData() {
            let charIndex = "\(object.Name.prefix(1))"
            if setArray.insert(charIndex).inserted {
                groupArray.append(charIndex)
                groups.append(SpecialistService.instance.getData().filter("Name BEGINSWITH '\(charIndex)'"))
            }
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard searchArray == nil else {
            return nil
        }
        return groupArray
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard searchArray == nil else {
            return nil
        }
        return groupArray[section]
    }
}
