//
//  ExploreViewController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/15.
//

import UIKit

class ExploreViewController: UIViewController {

    //MARK: - properties
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //MARK: - Helpers
    func configureUI(){
        
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }

}
