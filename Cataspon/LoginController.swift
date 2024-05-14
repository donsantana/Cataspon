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
        let vc = UIHostingController(rootView: LoginView())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)

    }
    
    @IBAction func loginAction(_ sender: Any) {
        moveToInfluencerHub()
        UserDefaults.standard.set(UserType.influencer.rawValue, forKey: "userTypeKey")
        let influencer = Client(id: "1", name: "Influencer One", sponsors: ["1","3","5"], contactInformation: ContactInformation(email: "test@test.com", phoneNumber: "7864475555", webURL: "url", logoURL: "logoUrl"))
        UserDefaults.standard.set(influencer, forKey: "userLogged")
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
    
    func moveToInfluencerHub() {
        let vc = UIHostingController(rootView: SponsorsView())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

