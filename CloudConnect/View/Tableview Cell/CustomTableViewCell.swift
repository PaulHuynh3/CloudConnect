//
//  CustomTableViewCell.swift
//  CloudConnect
//
//  Created by Paul on 2018-10-21.
//  Copyright © 2018 Paul. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var BRsanLabel: UILabel!
    @IBOutlet weak var ipNetworkLabel: UILabel!
    @IBOutlet weak var subnetLabel: UILabel!
    
    //API doesn't provide ant of these information
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var telephoneImageView: UIImageView!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var alarmImageView: UIImageView!
    
    @IBOutlet weak var cpuAlertLabel: UILabel!
    @IBOutlet weak var alarmCurrentStatusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setServerState(serverState: ServerState, cell: CustomTableViewCell) -> UITableViewCell {
        if serverState.location == 1 {
            cell.countryLabel.text = "Brazil"
        } else if serverState.location == 4 {
            cell.countryLabel.text = "Argentina"
        }
        cell.ipNetworkLabel.text = serverState.ipAddress
        cell.subnetLabel.text = serverState.ipSubnetMask
        
        let statusDict = serverState.status
        let statusValue = statusDict["statusValue"]
        if statusValue == "INSTANCE_STATE_UP" {
            alarmCurrentStatusButton.imageView?.image = UIImage(named: "BlueAlert")
        } else if statusValue == "INSTANCE_STATE_CHECKING" {
            alarmCurrentStatusButton.imageView?.image = UIImage(named: "YellowAlert")
        } else {
            alarmCurrentStatusButton.imageView?.image = UIImage(named: "RedAlert")
        }
        
        //change this depending on condition
        cpuAlertLabel.isHidden = true
        
        return cell
    }
}
