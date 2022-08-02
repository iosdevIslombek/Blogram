//
//  BlogsTVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

protocol BlogsTVCDelegate{
    func heartTapped(index:IndexPath)
}

class BlogsTVC: UITableViewCell {
    
    static func uinib()->UINib{
        return UINib(nibName: "BlogsTVC", bundle: nil)
    }
    
    static let identifier:String = "BlogsTVC"
    var index:IndexPath!
    var delegate:BlogsTVCDelegate?

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageVC: UIImageView!{
        didSet{
            imageVC.layer.cornerRadius = 20
            imageVC.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    }
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!{
        didSet{
            self.menuBtn.transform = self.menuBtn.transform.rotated(by: CGFloat(Double.pi/2))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    
    func updateCell(blog:BlogDM, index:IndexPath){
        imageVC.image = self.loadImage(key: blog.image)
        self.index = index
        
        likeBtn.imageView?.tintColor = blog.isLike ? .red : .gray
//        likeBtn.imageView?.backgroundColor = blog.isLike ? .red : .white
    }
    
    
    @IBAction func likeTapped(_ sender: Any) {
        delegate?.heartTapped(index: self.index)
    }
    
}
