//
//  UsersVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

class UsersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users:[UserDM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        setNavigationController()
        setTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = getUsers()
        tableView.reloadData()
    }
    
    func setTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UsersTVC.uinib(), forCellReuseIdentifier: UsersTVC.identifier)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension UsersVC:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AboutUserVC(nibName: "AboutUserVC", bundle: nil)
        vc.user = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.setBackground(count: users.count, image: "spider1")
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTVC.identifier, for: indexPath) as! UsersTVC
        cell.updateCell(user: users[indexPath.row])
        return cell
    }
}

