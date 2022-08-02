//
//  NewUserVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

protocol NewUserVCDelegate {
    func createNew(user:UserDM)
}

class NewUserVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var genderTf: UITextField!
    @IBOutlet weak var birthdayTf: UITextField!
    @IBOutlet weak var bioTv: UITextView!{
        didSet{
            bioTv.layer.borderWidth = 1
            bioTv.layer.borderColor = UIColor.lightGray.cgColor
            bioTv.layer.cornerRadius = 25
        }
    }
    
    var delegate:NewUserVCDelegate?
    var userIndex:Int = 0
    let datePicker = UIDatePicker()
    let picker = UIPickerView()
    var genderArr:[String] = ["Male", "Famale"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create User"
        setNavigationController()
        setDatePicker()
        setGenderPicker()
        navBarBtn()
    }
    
    func navBarBtn(){
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTappedNavbar))
        
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    @objc func doneTappedNavbar(){
        let user = UserDM(image: "userImage\(userIndex)",
                          name: nameTf.text!,
                          birthday: birthdayTf.text!,
                          gender: genderTf.text!,
                          bio: bioTv.text!)
        delegate?.createNew(user: user)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - SET DATE PICKER -
    
    func setDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(getDate), for: .valueChanged)
        birthdayTf.inputView = datePicker
        
        //MARK: - SET TOOLBAR -
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.items = [spaceBtn, doneBtn]
        birthdayTf.inputAccessoryView = toolbar
    }
    
    @objc func getDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        let myDay = formatter.string(from: datePicker.date)
        birthdayTf.text = myDay
    }
    
    @objc func doneTapped(){
        birthdayTf.resignFirstResponder()
    }
    
    //MARK: - SET GENDER PICKER -
    
    func setGenderPicker(){
        picker.delegate = self
        picker.dataSource = self
        genderTf.inputView = picker
        
        
        //MARK: - SET TOOLBAR -
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(genderDoneTapped))
        
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.items = [spaceBtn, doneBtn]
        genderTf.inputAccessoryView = toolbar
        
    }
    
    @objc func genderDoneTapped(){
        genderTf.resignFirstResponder()
    }
    
    @IBAction func editTapped(_ sender: Any) {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        imageVC.allowsEditing = true
        present(imageVC, animated: true)
    }
}

//MARK: - UIImagePickerController, UIImagePickerControllerDelegate -
extension NewUserVC:UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showAlert(title: "Error", desc: "\(picker)")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage]
        
        if let userImage = image as? UIImage {
            
            self.imageView.image = userImage
            
            guard let data = userImage.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
            UserDefaults.standard.set(encoded, forKey: "userImage\(userIndex)")
            
        }
        self.dismiss(animated: true)
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource -

extension NewUserVC:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTf.text = genderArr[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArr[row]
    }
}
