//
//  AnimationProfileVC.swift
//  Blogram
//
//  Created by Islomjon on 23/06/22.
//

import UIKit

class AnimationProfileVC: UIViewController {

    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.cornerRadius = 75
        }
    }
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    
    let w = UIScreen.main.bounds.width * 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.transform = CGAffineTransform(translationX: -w, y: 0)
        nameLbl.text = "Name: \(UserDefaults.standard.string(forKey: "USERNAME") ?? "")"
        genderLbl.text = "Gender: \(UserDefaults.standard.string(forKey: "GENDER") ?? "")"
        birthdayLbl.text = "Birthday: \(UserDefaults.standard.string(forKey: "BIRTHDAY") ?? "")"
        imageView.image = self.loadImage(key: "USERIMAGE")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.animationView.transform = .identity
        }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animationView.transform = CGAffineTransform(translationX: -w, y: 0)
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.animationView.transform = CGAffineTransform(translationX: -self.w, y: 0)
        }
//        dismiss(animated: false)
    }
    
    @IBAction func outsideTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }
}
