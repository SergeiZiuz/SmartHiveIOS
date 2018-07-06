//
//  SmartHiveViewController.swift
//  SmartHiveIOS
//
//  Created by Sergei Ziuzev on 7/4/18.
//  Copyright © 2018 Sergei Ziuzev. All rights reserved.
//

import UIKit

class SmartHiveViewController: UIViewController, UISplitViewControllerDelegate {
    
    var rooms: [Room]? = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if rooms != nil {
            if let tabelVC = (segue.destination.contents as? RoomsTableViewController) {
                tabelVC.tableRooms = rooms!
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = secondaryViewController.contents as? RoomsTableViewController, ivc.tableRooms == nil {
                return true
            }
        }
        return false
    }
    
    
    
    @IBAction func MTC(_ sender: UIButton) {
        rooms = XMLParse().getRooms("wgoc")
//        print(roomsMTC)
    }
    
    @IBAction func KHBP(_ sender: UIButton) {
        rooms = XMLParse().getRooms("khbp")
//        print(roomsKHBP)
    }
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
