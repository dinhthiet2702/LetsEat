//
//  TransparentBarNavViewController.swift
//  LetsEat
//
//  Created by thiet on 12/15/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class TransparentBarNavViewController: UIViewController {
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.hideKeyboardWhenTappedAround()
    }
    
    func hideButtonBack(_ Bool:Bool) {
        if Bool == true{
            let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
            navigationItem.leftBarButtonItem = backButton
        }
        else{
            CustomBackItem()
        }
        
    }
    func CustomBackItem() {
           let segmentBarItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(back))
           navigationItem.leftBarButtonItem = segmentBarItem
       }
        @objc func back() {
           self.navigationController?.popViewController(animated: true)
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
extension TransparentBarNavViewController:UISearchBarDelegate{
    func creatSearchBar(placeholder:String){
        
        searchBar.placeholder = placeholder
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}
extension TransparentBarNavViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        searchBar.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap)

    }
    @objc func dismissKeyboard() {
        searchBar.endEditing(true)
        view.endEditing(true)
    }
}
