//
//  ViewController.swift
//  CloudConnect
//
//  Created by Paul on 2018-10-19.
//  Copyright © 2018 Paul. All rights reserved.
//

import UIKit

class ServerViewController: UIViewController {
    var serverStateArray = Array<ServerState>()

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveServerStateArray()
    }

    func retrieveServerStateArray() {
        API().fetchAllServerState(page: 0) { (serverArray: Array<ServerState>?, error: String?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
            guard let serverArray = serverArray else {return}
            
            self.serverStateArray = serverArray
        }
    }
    
    
}

extension ServerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return serverStateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! CustomTableViewCell
       let serverState = serverStateArray[indexPath.row]
        
        let customizedCell = cell.setServerState(serverState: serverState, cell: cell)
        
        return customizedCell
    }
    
    
    
}

