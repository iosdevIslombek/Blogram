//
//  Extensions.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlert(title:String, desc:String){
        let alertVC = UIAlertController(title: title, message: desc, preferredStyle: .actionSheet)
        let okBtn = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(okBtn)
        present(alertVC, animated: true)
    }
    
    func saveBlog(blog:[BlogDM]){
        let encoder = JSONEncoder()
        if let encoderBlog = try? encoder.encode(blog){
            let userdefault = UserDefaults.standard
            userdefault.set(encoderBlog, forKey: "BLOG")
        }
    }

    func getBlogs()->[BlogDM]{
        let userdefault = UserDefaults.standard
        if let myBlogs = userdefault.object(forKey: "BLOG") as? Data{
            let decoder = JSONDecoder()
            if let decodeBlog = try? decoder.decode([BlogDM].self, from: myBlogs){
                return decodeBlog
            }
        }
        return []
    }
    
    func saveUser(user:[UserDM]){
        let encoder = JSONEncoder()
        if let encoderBlog = try? encoder.encode(user){
            let userdefault = UserDefaults.standard
            userdefault.set(encoderBlog, forKey: "USER")
        }
    }
    
    func getUsers()->[UserDM]{
        let userdefault = UserDefaults.standard
        if let myUsers = userdefault.object(forKey: "USER") as? Data{
            let decoder = JSONDecoder()
            if let decodeUser = try? decoder.decode([UserDM].self, from: myUsers){
                return decodeUser
            }
        }
        return []
    }
   
    func loadImage(key:String)->UIImage{
        guard let data = UserDefaults.standard.data(forKey: key) else{ return UIImage(systemName: "person.fill")!}
        let decoded = try! PropertyListDecoder().decode(Data.self, from:data)
        let image = UIImage(data: decoded)
        return image ?? UIImage(systemName: "person.fill")!
    }
    
    func setupNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = .black

        let font:UIFont = UIFont(name: "Arial", size: 25)!
        let navbarTitleAtt = [
            NSAttributedString.Key.font:font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().titleTextAttributes = navbarTitleAtt
    }
    
    func setNavigationController(){
        let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = .systemGray4
                appearance.titleTextAttributes = [.foregroundColor: UIColor.red]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
                appearance.titleTextAttributes = [
                    .foregroundColor : UIColor.purple,
                    .font : UIFont.italicSystemFont(ofSize: 24)
                ]
//                navigationItem.backBarButtonItem?.tintColor = .purple
                navigationController?.navigationBar.tintColor = .purple
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.compactAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension UITableViewCell{
    func loadImage(key:String)->UIImage{
        guard let data = UserDefaults.standard.data(forKey: key) else{ return UIImage(systemName: "person.fill")!}
        let decoded = try! PropertyListDecoder().decode(Data.self, from:data)
        let image = UIImage(data: decoded)
        return image ?? UIImage(systemName: "person.fill")!
    }
}


extension UITableView{
    func setBackground(count:Int, image:String){
        if count > 0{
            self.backgroundView = nil
        }else{
            let imageView = UIImageView(image: UIImage(named: image))
            imageView.frame = self.frame
            self.backgroundView = imageView
        }
        
    }
}

