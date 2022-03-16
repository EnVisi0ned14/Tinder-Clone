//
//  HomeController.swift
//  TinderClone
//
//  Created by Michael Abrams on 3/15/22.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let topStack = HomeNavigationStackView()
    
    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    
    }
    
    // MARK: Helpers
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(topStack)
        topStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor)
        
        
    }
}
