//
//  ProfileViewController.swift
//  LetsEat
//
//  Created by thiet on 12/24/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit
import Alamofire

var user:User!

class ProfileViewController: TransparentBarNavViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("Image2.png")
           let image    = UIImage(contentsOfFile: imageURL.path)
           // Do whatever you want with the image
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LogOut(_ sender: UIButton) {
        let scence = self.view.window?.windowScene?.delegate as! SceneDelegate
        scence.logOut()
        UserDefaults.standard.removeObject(forKey: "token")
        scence.logOut()
    }
    @IBAction func UploadFoods(_ sender: Any) {
        let forSaleVC = sb.instantiateViewController(identifier: "ForSaleViewController") as! ForSaleViewController
        
        self.navigationController?.pushViewController(forSaleVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
