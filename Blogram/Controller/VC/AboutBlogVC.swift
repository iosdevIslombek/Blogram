//
//  AboutBlogVC.swift
//  Blogram
//
//  Created by Islomjon on 19/06/22.
//

import UIKit

class AboutBlogVC: UIViewController {

    @IBOutlet weak var blogImage: UIImageView!
    
    @IBOutlet weak var descLbl: UILabel!
    
    var blog:BlogDM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        setUpData()
    }
    
    func setUpData(){
        navigationItem.title = blog.title
        blogImage.image = loadImage(key: blog.image )
        descLbl.text = blog.description
    }

}
