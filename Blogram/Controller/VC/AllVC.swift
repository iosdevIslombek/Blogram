//
//  AllVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

class AllVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var blogs:[BlogDM] = []
    var users:[UserDM] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Blogram"
        setNavigationController()
        setTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blogs = getBlogs()
        users = getUsers()
        tableView.reloadData()
    }
    
    
    func setTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BlogsTVC.uinib(), forCellReuseIdentifier: BlogsTVC.identifier)
        tableView.register(UsersTVC.uinib(), forCellReuseIdentifier: UsersTVC.identifier)

        let addBlogramBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addBlogramTapped))
        
        let profileBtn = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(profileTapped))
        
        navigationItem.rightBarButtonItem = addBlogramBtn
        navigationItem.leftBarButtonItem = profileBtn
    }
    
    @objc func addBlogramTapped(){
        addBlogramAlert()
    }
    
    @objc func profileTapped(){
        let vc = AnimationProfileVC(nibName: "AnimationProfileVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
}

//MARK: - Alert -
extension AllVC{
    func addBlogramAlert(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let addBlogBtn = UIAlertAction(title: "Create Blog", style: .default) { _ in
            let newBlog = NewBlogVC(nibName: "NewBlogVC", bundle: nil)
            newBlog.delegate = self
            newBlog.blogIndex = self.blogs.count
            self.navigationController?.pushViewController(newBlog, animated: true)
        }
        let addUserBtn = UIAlertAction(title: "Create User", style: .default) { _ in
            let newUser = NewUserVC(nibName: "NewUserVC", bundle: nil)
            newUser.userIndex = self.users.count
            newUser.delegate = self
            self.navigationController?.pushViewController(newUser, animated: true)
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        alertVC.addAction(addBlogBtn)
        alertVC.addAction(addUserBtn)
        alertVC.addAction(cancelBtn)
        present(alertVC, animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AllVC:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            let vc = AboutBlogVC(nibName: "AboutBlogVC", bundle: nil)
            vc.blog = blogs[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = AboutUserVC(nibName: "AboutUserVC", bundle: nil)
            vc.user = users[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.setBackground(count: (blogs.count+users.count), image: "spider")
        return section == 0 ? blogs.count : users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: BlogsTVC.identifier, for: indexPath) as! BlogsTVC
            cell.updateCell(blog: blogs[indexPath.row], index: indexPath)
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: UsersTVC.identifier, for: indexPath) as! UsersTVC
            cell.updateCell(user: users[indexPath.row])
            return cell
        }
    }
}


//MARK: - BlogsTVCDelegate -

extension AllVC:BlogsTVCDelegate{
    func heartTapped(index: IndexPath) {
        self.blogs[index.item].isLike = !blogs[index.item].isLike
        self.saveBlog(blog: self.blogs)
        tableView.reloadData()
    }
}


//MARK: - NewBlogVCDelegate -

extension AllVC:NewBlogVCDelegate{
    func createNew(blog: BlogDM) {
        self.blogs.append(blog)
        self.saveBlog(blog: blogs)
        tableView.reloadData()
    }
}



//MARK: - NewUserVCDelegate
extension AllVC:NewUserVCDelegate{
    func createNew(user: UserDM) {
        self.users.append(user)
        self.saveUser(user: users)
        tableView.reloadData()
    }
}



