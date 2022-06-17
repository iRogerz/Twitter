//
//  NotificationsViewController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/15.
//

import UIKit

class NotificationsViewController: UIViewController {

    //MARK: - properties
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI(){
        
        view.backgroundColor = .white
        let imageTitle = UIImageView(image:UIImage(named: "twitter_logo_blue"))
        imageTitle.contentMode = .scaleAspectFit
        navigationItem.titleView = imageTitle
    }

}
