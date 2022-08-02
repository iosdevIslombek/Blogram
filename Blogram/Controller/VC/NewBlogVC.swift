//
//  NewBlogVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

protocol NewBlogVCDelegate{
    func createNew(blog:BlogDM)
}

class NewBlogVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.borderWidth = 1
        }
    }
    var delegate:NewBlogVCDelegate?
    var blogIndex:Int = 0
    
    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var descriptionTv: UITextView!{
        didSet{
            descriptionTv.layer.borderWidth = 1
            descriptionTv.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Blog"
        setNavigationController()
    }
    
    @IBAction func editTapped(_ sender: Any) {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        imageVC.allowsEditing = true
        present(imageVC, animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let newBlog = BlogDM(image: "blogImage\(blogIndex)",
                             title: titleTf.text!,
                             description: descriptionTv.text,
                             isLike: false)
        delegate?.createNew(blog: newBlog)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UIImagePickerController, UIImagePickerControllerDelegate -
extension NewBlogVC:UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showAlert(title: "Error", desc: "\(picker)")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage]
        
        if let blogImage = image as? UIImage {
            
            self.imageView.image = blogImage
            
            guard let data = blogImage.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
            UserDefaults.standard.set(encoded, forKey: "blogImage\(blogIndex)")
        }
        self.dismiss(animated: true)
    }
    
}
