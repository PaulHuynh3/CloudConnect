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
    var pageNumber = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNumber = 0
        retrieveServerStateArray(pageNumber: pageNumber)
    }

    func retrieveServerStateArray(pageNumber: Int) {
        API().fetchAllServerState(page: pageNumber) { (serverArray: Array<ServerState>?, error: String?) in
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

//MARK: UIScrollViewDelegate
extension ServerViewController {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            processScrollInScrollView(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        processScrollInScrollView(scrollView)
    }
    
    //determine end of page
    func processScrollInScrollView(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if bottomEdge >= scrollView.contentSize.height {
            //load next screen
        } else {
            
        }
    }
    
    func loadNextScreen(scrollView: UIScrollView) {
        //bottom of screen
        pageNumber = pageNumber + 1
        retrieveServerStateArray(pageNumber: pageNumber)
    }
    
}
