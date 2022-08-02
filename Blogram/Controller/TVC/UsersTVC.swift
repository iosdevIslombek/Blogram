//
//  UsersTVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

class UsersTVC: UITableViewCell {
    
    static func uinib()->UINib{
        return UINib(nibName: "UsersTVC", bundle: nil)
    }
    
    static let identifier:String = "UsersTVC"
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func updateCell(user:UserDM){
        imageV.image = self.loadImage(key: user.image)
        nameLbl.text = user.name
        birthdayLbl.text = user.birthday
        genderLbl.text = user.gender
    }
    
}
