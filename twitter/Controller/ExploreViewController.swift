//
//  ExploreViewController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/15.
//

import UIKit

private let reuseIdentifier = "UserCell"

class ExploreViewController: UITableViewController {

    //MARK: - properties
    private var users = [User](){
        didSet{ tableView.reloadData() }
    }
    
    private var filterUsers = [User](){
        didSet { tableView.reloadData() }
    }
    
    private var inSearchMode: Bool {
        return searchController.isActive &&
        !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.overrideUserInterfaceStyle = .light
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - API
    func fetchUser(){
        UserService.shared.fetchUsers { users in
//            users.forEach { user in
//                print("DEBUG: user is \(user.username)")
//            }
            self.users = users
        }
    }
    
    //MARK: - Helpers
    func configureUI(){
        
        view.backgroundColor = .white
        navigationItem.title = "Explore"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        //清除分隔線
        tableView.separatorStyle = .none
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
    }
}

//MARK: - UITableViewDelegate/DateSource
extension ExploreViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filterUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UserCell else { return UITableViewCell()}
        let user = inSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filterUsers[indexPath.row] : users[indexPath.row]
        let controller = PofileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UISearchResultsUpdating
extension ExploreViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filterUsers = users.filter( { $0.username.contains(searchText)} )
    }
    
    
}
