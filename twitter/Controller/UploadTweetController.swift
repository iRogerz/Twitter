//
//  UploadTweetController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/7/19.
//

import UIKit

class UploadTweetController: UIViewController{
    
    //MARK: - properties
    private lazy var tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - selectors
    @objc func handleCancel(){
        dismiss(animated: true)
    }
    
    @objc func handleUploadTweet(){
        print("DEBUG: button!!")
    }
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
//        navigationController?.navigationBar.tintColor = .twitterBlue
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
}
