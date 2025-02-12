//
//  PofileController.swift
//  twitter
//
//  Created by 曾子庭 on 2022/8/1.
//

import UIKit

private let reuseIdentifier = "Cell"
private let headerIdentifier = "PofileHeader"

class PofileController: UICollectionViewController {

    //MARK: - properties
    private var user: User
    
    
    private var tweets = [Tweet](){
        didSet{ collectionView.reloadData() }
    }
    
    
    //MARK: - Lifecycle
    init(user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchTweets()
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isHidden = true
    }
    //MARK: - API
    func fetchTweets(){
        TweetService.shared.fetchTweets(forUser: user) { tweets in
            self.tweets = tweets
        }
    }
    
    func checkIfUserIsFollowed(){
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats(){
        UserService.shared.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Helpers
    func configureCollectionView(){
        //sroll view 原本會自動在上方加上inset，取消之後就可以填滿上方螢幕
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(PofileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
   
    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tweets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
     
        cell.tweet = tweets[indexPath.row]
        return cell
    }


}
extension PofileController {
    //建立pofileHeader
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! PofileHeader
        header.user = user
        header.delegate = self
        return header
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PofileController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }

}

//MARK: - PofileHeaderDelegate
extension PofileController: PofileHeaderDelegate{
    func handleEditPofileFollow(_ header: PofileHeader) {
        
        if user.isCurrentUser{ return }
        
        if user.isFollowed{
            UserService.shared.unfollowUser(uid: user.uid) { err, ref in
                print(self.user.isFollowed)
                self.user.isFollowed = false
                header.editPofileButton.setTitle("Follow", for: .normal)
            }
        }else{
            UserService.shared.followUser(uid: user.uid) { err, ref in
                print(self.user.isFollowed)
                self.user.isFollowed = true
                header.editPofileButton.setTitle("Following", for: .normal)
            }
        }
     
    }
    
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
        
}
