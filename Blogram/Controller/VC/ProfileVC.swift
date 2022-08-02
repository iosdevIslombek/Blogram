//
//  ProfileVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.cornerRadius = 75
        }
    }
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var genderlbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My profile"
        setNavigationController()
        nameLbl.text = "Name: \(UserDefaults.standard.string(forKey: "USERNAME") ?? "")"
        genderlbl.text = "Gender: \(UserDefaults.standard.string(forKey: "GENDER") ?? "")"
        birthdayLbl.text = "Birthday: \(UserDefaults.standard.string(forKey: "BIRTHDAY") ?? "")"
        imageView.image = self.loadImage(key: "USERIMAGE")
        setNavigationButton()
    }
    
    func setNavigationButton(){
        let likeBarButton = UIBarButtonItem(image: UIImage(named: "heart1"),
                                          style: .done,
                                          target: self,
                                          action: #selector(likeBarTapped))
        likeBarButton.tintColor = .red
        
        let saveBarButton = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"),
                                         style: .done,
                                         target: self,
                                         action: #selector(saveBarTapped))
        saveBarButton.tintColor = .darkGray
        
        navigationItem.rightBarButtonItems = [saveBarButton, likeBarButton]
    }
    
    @objc func likeBarTapped(){
        let vc = BlogsVC(nibName: "BlogsVC", bundle: nil)
        vc.isLikeVC = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func saveBarTapped(){
        print("save")
    }
}
