//
//  HomeController.swift
//  TinderClone
//
//  Created by Michael Abrams on 3/15/22.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlsStackView()
    
    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        configureUI()
        configureCards()
        //logout()
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if(Firebase.Auth.auth().currentUser == nil) {
            presentLoginController()
        }
        else {
            print("DEBUG: User is logged in...")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginController()
        }
        catch {
            print("DEBUG: Failed to sign out...")
        }
    }
    
    // MARK: Helpers
    
    func configureCards() {
        
        let user1 = User(name: "Jane Doe", age: 22, images: [#imageLiteral(resourceName: "lady4c"), #imageLiteral(resourceName: "jane3")])
        let user2 = User(name: "Megan", age: 21, images: [#imageLiteral(resourceName: "lady5c"), #imageLiteral(resourceName: "kelly1")])
        
        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
        
        deckView.addSubview(cardView1)
        deckView.addSubview(cardView2)
        
        cardView1.fillSuperview()
        cardView2.fillSuperview()
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack, deckView, bottomStack])
        stack.axis = .vertical
        view.addSubview(stack)
        
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.rightAnchor)
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        
        
    }
    
    func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false, completion: nil)
        }
    }
}
