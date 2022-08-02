//
//  AboutUserVC.swift
//  Blogram
//
//  Created by Islomjon on 19/06/22.
//

import UIKit

class AboutUserVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var user:UserDM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        navigationItem.backBarButtonItem?.tintColor = .purple
        setUpData()
    }
    
    func setUpData(){
        navigationItem.title = user.name
        userImage.image = loadImage(key: user.image)
        usernameLbl.text = user.name
        genderLbl.text = user.gender
        birthdayLbl.text = user.birthday
        descLbl.text = user.bio
    }
}
