//
//  ViewController.swift
//  Cataspon
//
//  Created by Done Santana on 4/10/24.
//

import UIKit
import SwiftUI

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func loginAction(_ sender: Any) {
        //moveToClientView()
        moveToGuestHub()
        UserDefaults.standard.set(UserType.influencer.rawValue, forKey: "userTypeKey")
    }
    
    @IBAction func loginAsGuest(_ sender: Any) {
        UserDefaults.standard.set(UserType.guest.rawValue, forKey: "userTypeKey")
        moveToGuestHub()
    }
    
    func moveToGuestHub() {
        let vc = UIHostingController(rootView: ClientsView())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

