//
//  ViewController.swift
//  facebook_feed_programatically
//
//  Created by parth on 7/7/16.
//  Copyright © 2016 parthanand.com. All rights reserved.
//

import UIKit

let cellId = "cellId"

class Post{
    
    var name : String?
    var statusText : String?
    var profileImageName : String?
    var statusImageName : String?
    var numLikes : Int?
    var numComments : Int?
    var imageUrl : String?
}


class FeedController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = NSURLCache(memoryCapacity: memoryCapacity , diskCapacity: diskCapacity , diskPath: "myDiskPath")
        NSURLCache.setSharedURLCache(urlCache)
        
        ////////DATA/////////DATA///////DATA/////DATA
        
//        let postMark = Post()
//        postMark.name = "Mark Zuckerburg"
//        postMark.statusText = "Meanwhile , beast turned to the dark side"
//        postMark.profileImageName = "zuckprofile"
//        postMark.statusImageName = "zuckdog"
//        postMark.numLikes = 400
//        postMark.numComments = 123
//        postMark.imageUrl = "https://newevolutiondesigns.com/images/freebies/tropical-beach-background-8.jpg"
//        
//        
//        let postSteve = Post()
//        postSteve.name = "Steve Jobs"
//        postSteve.statusText = "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me " +
//        "Sometimes when you innovate, you make mistakes It is best to admit them quickly, and get on with improving your other innovations"
//        postSteve.profileImageName = "steveprofile"
//        postSteve.statusImageName = "stevepost"
//        postSteve.numLikes = 4000
//        postSteve.numComments = 1323
//        postSteve.imageUrl = "https://talentdevelop.com/WordPress/wp-content/uploads/2014/03/Steve-Jobs-Think-Different.jpg"
//        
//        let postGandhi = Post()
//        postGandhi.name = "Mahatma Gandhi"
//        postGandhi.statusText = "practice non voilence . if a person slaps you , brong your other side of your face infront of him"
//        postGandhi.profileImageName = "gandhi"
//        postGandhi.numLikes = 400
//        postGandhi.numComments = 123
//        postGandhi.imageUrl = "https://timedotcom.files.wordpress.com/2014/12/gandhi-spinning-wheel-02.jpg?quality=75&strip=color&w=715"
//        
//        let postDonald = Post()
//        postDonald.name = "Donald Trumph"
//        postDonald.statusText = "i know i am mad , but i am a billionare and you cannot do anything to stop me. i am an idiot btw"
//        postDonald.profileImageName = "donald"
//        postDonald.numLikes = 400
//        postDonald.numComments = 123
//        postDonald.imageUrl = "https://ppcorn.com/us/wp-content/uploads/sites/14/2015/12/Donald-Trump-ppcorn.jpg"
//        
//        posts.append(postMark)
//        posts.append(postSteve)
//        posts.append(postGandhi)
//        posts.append(postDonald)
       

    navigationItem.title = "facebook feed"
        
    collectionView?.alwaysBounceVertical = true
        
    collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
    collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath.item]
        
        feedCell.feedController = self
        return feedCell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        if let statusText = posts[indexPath.item].statusText {
        
            let rect = NSString(string: statusText).boundingRectWithSize(CGSizeMake(view.frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14)], context: nil)
        
            
            let knownHeight : CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSizeMake(view.frame.width, rect.height + knownHeight + 24)
        }
        
        
        return CGSizeMake(view.frame.width, 500)
    }
    
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }

    let zoomImageView = UIImageView()

    let blackBackgroundView = UIView()
    
    let navBarCoverView = UIView()
    
    let tabBarCoverView = UIView()
    
    var statusImageView : UIImageView?
    
    func animateImageView(statusImageView : UIImageView){
        
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convertRect(statusImageView.frame, toView: nil){
        
            statusImageView.alpha = 0
            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = UIColor.blackColor()
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            
            navBarCoverView.frame = CGRectMake(0, 0, 1000, 20 + 44)
            navBarCoverView.backgroundColor = UIColor.blackColor()
            navBarCoverView.alpha = 0
            
            if let keyWindow = UIApplication.sharedApplication().keyWindow{
            
                keyWindow.addSubview(navBarCoverView)
                
                tabBarCoverView.frame = CGRectMake(0, keyWindow.frame.height - 49, 1000, 49)
                tabBarCoverView.backgroundColor = UIColor.blackColor()
                tabBarCoverView.alpha = 0
                keyWindow.addSubview(tabBarCoverView)
            }
            
            
            
        zoomImageView.backgroundColor = UIColor.redColor()
        zoomImageView.frame = startingFrame
        zoomImageView.userInteractionEnabled = true
        zoomImageView.image = statusImageView.image
        zoomImageView.contentMode = .ScaleAspectFill
        zoomImageView.clipsToBounds = true
        view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:"zoomOut"))

            
            UIView.animateWithDuration(0.75 , delay: 0 , usingSpringWithDamping: 1,
                                       initialSpringVelocity: 0.5,options: .CurveEaseOut,animations: { () -> Void in
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.frame = CGRectMake(0 , y , self.view.frame.width , height)
             
                self.blackBackgroundView.alpha = 1
                
                self.navBarCoverView.alpha = 1
                
                self.tabBarCoverView.alpha = 1
            } , completion: nil)
    
        }
    }
    
    func zoomOut(){
    
        if let startingFrame = statusImageView!.superview?.convertRect(statusImageView!.frame, toView: nil){
        
        
           
            
            UIView.animateWithDuration(0.75 , delay: 0 , usingSpringWithDamping: 1,
                                       initialSpringVelocity: 0.5,options: .CurveEaseOut,animations: { () -> Void in
                
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
                
                }, completion: { (didComplete) -> Void in
                    self.zoomImageView.removeFromSuperview()
                    self.blackBackgroundView.removeFromSuperview()
                    self.navBarCoverView.removeFromSuperview()
                    self.tabBarCoverView.removeFromSuperview()
                    self.statusImageView?.alpha = 1
                    
            
            
            })
            
        }
    
    }
    

}


class FeedCell : UICollectionViewCell {
    
    var feedController : FeedController?
    
    func animate(){
    
    feedController?.animateImageView(statusImageView)
    
    }

    var post : Post? {
    
        didSet{
        
            if let name = post?.name {
            
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)])
            
            attributedText.appendAttributedString(NSAttributedString(string: "\ndecember 18  . sanfransisco  .", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12),NSForegroundColorAttributeName : UIColor.rgb(155, green: 161, blue: 161)]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0,attributedText.string.characters.count))
            
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named : "globe_small")
            attachment.bounds = CGRectMake(0, -2, 12, 12)
            attributedText.appendAttributedString(NSAttributedString(attachment : attachment))
            
            
            nameLabel.attributedText = attributedText
            }
        
            
            if let statusText = post?.statusText {
            
                statusTextView.text = statusText
            
            }
            
            if let profileImagename = post?.profileImageName {
            
                profileImageView.image = UIImage(named : profileImagename)
                
            }
            
            if let statusImageName = post?.statusImageName {
            
                statusImageView.image = UIImage(named : statusImageName)
                
            }
            
            
            statusImageView.image = nil
            
            if let statusUrl = post?.imageUrl {
            
                
                
                
                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string : statusUrl)! ,completionHandler: {(data , response , error) -> Void in
                
                    if error != nil {
                    
                    print(error)
                        return
                        
                    }
                    
                    let image = UIImage(data : data!)
                    
                    dispatch_async(dispatch_get_main_queue() , { () -> Void in
                    self.statusImageView.image = image
                        
                        
                    })
                
                }).resume()
            
                
                    
            }
            
        }
    
    }
    
    // called whenever the cell is dequed
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel : UILabel = {
    
        let label = UILabel()
        label.numberOfLines = 2
        
        
        
        return label
    
    }()
    
    let profileImageView : UIImageView = {
    
        let imageView = UIImageView()
        imageView.image = UIImage(named : "zuckprofile")
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    
    
    let statusTextView : UITextView = {
        let textView = UITextView()
        textView.text = "meanwhile, beast turned to the dark side"
        textView.font = UIFont.systemFontOfSize(14)
        textView.scrollEnabled = false
        return textView
    
    
    }()
    
    
    let statusImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckdog")
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.userInteractionEnabled = true
        return imageView
    
    }()
    
    let likesCommentsLabel : UILabel = {
    
        let label = UILabel()
        label.text = "488 Likes   10.7k Comments"
        label.font  = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        return label
    }()
    
    
    let dividerLineView : UIView = {
    
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        return view
    }()
    
    
    let likeButton = FeedCell.buttonForTitle("Like", imageName: "like")
    let commentButton = FeedCell.buttonForTitle("Comment", imageName: "comment")
    let shareButton = FeedCell.buttonForTitle("Share", imageName: "share")
    
    
    static func buttonForTitle(title : String , imageName : String) -> UIButton {
    
              let button = UIButton()
              button.setTitle(title, forState: .Normal)
              button.setTitleColor(UIColor.rgb(143, green: 150, blue: 163), forState: .Normal)
              button.setImage(UIImage(named  : imageName), forState: .Normal)
              button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
              button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
                return button
    }
    
    
    
    
    func setUpViews(){
    backgroundColor = UIColor.whiteColor()
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:"animate"))
        
        
        addConstraintWithFormat("H:|-8-[v0(44)]-8-[v1]|", views: profileImageView , nameLabel)
        
        addConstraintWithFormat("H:|-4-[v0]-4-|", views: statusTextView)

        addConstraintWithFormat("H:|[v0]|", views: statusImageView)
        
        addConstraintWithFormat("H:|-12-[v0]|", views: likesCommentsLabel)
        
        addConstraintWithFormat("H:|-12-[v0]-12-|", views: dividerLineView)
        
        addConstraintWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: likeButton ,commentButton , shareButton)

        addConstraintWithFormat("V:|-12-[v0]", views: nameLabel)
        
        addConstraintWithFormat("V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.5)][v5(44)]|", views: profileImageView , statusTextView , statusImageView , likesCommentsLabel ,dividerLineView , likeButton)
        
        addConstraintWithFormat("V:[v0(44)]|", views: commentButton)
        
        addConstraintWithFormat("V:[v0(44)]|", views: shareButton)

       
        
        
        
    }

}

extension UIColor{

    static func rgb(red : CGFloat , green : CGFloat , blue : CGFloat) -> UIColor {
    
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    
    }

}

extension UIView {

    func addConstraintWithFormat(format : String , views : UIView...){
        var viewsDictionary = [String : UIView]()
        
        for (index , view) in views.enumerate() {
        let key = "v\(index)"
        viewsDictionary[key] = view
        view.translatesAutoresizingMaskIntoConstraints = false
        
        }
    
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    
    }

}

