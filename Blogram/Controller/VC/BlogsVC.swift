//
//  BlogsVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

class BlogsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var blogs:[BlogDM] = []
    var isLikeVC:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = isLikeVC ? "Favorite Blogs" : "Blogs"
        setNavigationController()
        setTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blogs = getBlogs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blogs = isLikeVC ? getLikeBlogs() : blogs
        tableView.reloadData()
    }
    
    func getLikeBlogs()->[BlogDM]{
        var likeBlogs:[BlogDM] = []
        likeBlogs = blogs.filter({ blog in
            blog.isLike
        })
        
        return likeBlogs
    }
    
    func setTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(BlogsTVC.uinib(), forCellReuseIdentifier: BlogsTVC.identifier)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension BlogsVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AboutBlogVC(nibName: "AboutBlogVC", bundle: nil)
        vc.blog = blogs[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.setBackground(count: blogs.count, image: "spider1")
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BlogsTVC.identifier, for: indexPath) as! BlogsTVC
        cell.updateCell(blog: blogs[indexPath.row], index: indexPath)
        cell.delegate = self
        return cell
    }
}


//MARK: - BlogsTVCDelegate

extension BlogsVC:BlogsTVCDelegate{
    func heartTapped(index: IndexPath) {
        blogs[index.row].isLike = !blogs[index.row].isLike
        self.saveBlog(blog: self.blogs)
        tableView.reloadData()
    }
}
