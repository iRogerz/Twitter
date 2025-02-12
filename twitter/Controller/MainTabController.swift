//
//  MainTabController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/15.
//

import UIKit
import Firebase
import FirebaseAuth

class MainTabController: UITabBarController {
    
    var user: User?{
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedViewController else { return }
            feed.user = user
        }
    }
    //MARK: - properties
    
    lazy var actionButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 56/2
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
//                logUserOut()
        fetchUser()
        authenticateUserAndConfigureUI()
        
    }
    //MARK: - API
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }else{
            configureViewControllers()
            configureUI()
        }
    }
    //為了讓預設是登出狀態所以要執行一次此函式
    func logUserOut(){
        do{
            try Auth.auth().signOut()
            print("BEDUG:Did log user out...")
        }catch let error{
            print("DEBUG: fail to signout \(error.localizedDescription)")
        }
    }
    //MARK: - selectors
    @objc func actionButtonTapped(){
        guard let user = user else { return }
        print("roger")
        let controller = UploadTweetController(user: user, config: .tweet)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func configureUI(){
        //讓tabbar 跟navbar顯示預設的毛玻璃效果，原本預設是nil所以bar會跟背景融合
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-64)
            make.width.height.equalTo(56)
        }
    }
    
    //MARK: - Helpers
    
    func configureViewControllers(){
        let feed = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let feedNav = templateNavigationController(image: UIImage(named: "home_unselected"), rootController: feed)
        
        let explore = ExploreViewController()
        let exploreNav = templateNavigationController(image: UIImage(named: "search_unselected"), rootController: explore)
        
        let notifications = NotificationsViewController()
        let notificationNav = templateNavigationController(image: UIImage(named: "like_unselected"), rootController: notifications)
        
        let conversation = ConversationsViewController()
        let conversationNav = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootController: conversation)
        
        self.tabBar.barTintColor = .clear
        //        self.tabBar.tintColor = .orange
        viewControllers = [feedNav, exploreNav, notificationNav, conversationNav]
        
    }
    
    func templateNavigationController(image: UIImage?, rootController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        
        return nav
    }
    
}
