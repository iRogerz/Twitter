//
//  FeedViewController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/6/15.
//

import UIKit
import SDWebImage

//private let reuseIdentifier = "tweetCell"

class FeedViewController: UICollectionViewController {

    var user: User?{
        didSet{ configLeftBarButton() }
    }
    
    private var tweets = [Tweet](){
        didSet{ collectionView.reloadData() }
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
        fetchTweet()
        //為了在點擊按鈕時能出現highlight所以
        collectionView.delaysContentTouches = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.overrideUserInterfaceStyle = .light
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - API
    func fetchTweet(){
        TweetService.shared.fetchTweets { tweets in
            print("DEBUG: tweets are \(tweets.count)")
            self.tweets = tweets
        }
    }
    //MARK: - Helpers
    func configureUI(){
//        view.backgroundColor = .white
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.identifier)
        let imageTitle = UIImageView(image:UIImage(named: "twitter_logo_blue"))
        imageTitle.contentMode = .scaleAspectFit
        imageTitle.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageTitle
        
        
    }
    
    func configLeftBarButton(){
        guard let user = user else { return }
//        guard let url = URL(string: user.pofileImageURL) else { return }
        pofileImageView.sd_setImage(with: user.pofileImageURL)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: pofileImageView)
    }
}

//MARK: - UICollectionViewDelegate/DataSource
extension FeedViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.identifier, for: indexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }

}
 
//MARK: - TweetCellDelegate
extension FeedViewController:TweetCellDelegate{
    func handlePofileImageTapped(_ cell: TweetCell) {
        guard let user = cell.tweet?.user else { return }
        let controller = PofileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }

}
