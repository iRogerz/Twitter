//
//  FeedViewController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/15.
//

import UIKit
import SDWebImage

class FeedViewController: UIViewController {

    var user: User?{
        didSet{ configLeftBarButton() }
    }
    //MARK: - properties
    let pofileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setDimensions(width: 32, height: 32)
        imageView.layer.cornerRadius = 32 / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
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
    
    func configLeftBarButton(){
        guard let user = user else { return }
        guard let url = URL(string: user.pofileImageURL) else { return }
        pofileImageView.sd_setImage(with: url)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: pofileImageView)
    }
}
