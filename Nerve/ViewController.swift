//
//  ViewController.swift
//  Nerve
//
//  Created by Mellani Garzon on 05/07/22.
//

import AVFoundation
import UIKit
import AVKit
import AudioToolbox
import LocalAuthentication

class ViewController: UIViewController {
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NERVE"
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.95, green: 0.98, blue: 0.16, alpha: 1.00)
        label.font = UIFont(name: "Oswald-Bold", size: 200)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowColor = UIColor(red: 0.95, green: 0.98, blue: 0.16, alpha: 1.00).cgColor
        label.layer.shadowRadius = 10.0
        label.layer.shadowOpacity = 0.6
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var watcherButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitle("WATCHER", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(red: 0.95, green: 0.02, blue: 0.82, alpha: 1.00), for: .normal)
        button.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 150)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.layer.shadowColor = UIColor(red: 0.95, green: 0.02, blue: 0.82, alpha: 1.00).cgColor
        button.titleLabel?.layer.shadowRadius = 15.0
        button.titleLabel?.layer.shadowOpacity = 0.7
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 3)
        button.addTarget(self, action: #selector(watcherButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var playerButton: UIButton = {
        let button = UIButton()
        button.setTitle("PLAYER", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(red: 0.96, green: 0.00, blue: 0.02, alpha: 1.00), for: .normal)
        button.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 150)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.layer.shadowColor = UIColor(red: 0.96, green: 0.00, blue: 0.02, alpha: 1.00).cgColor
        button.titleLabel?.layer.shadowRadius = 15.0
        button.titleLabel?.layer.shadowOpacity = 0.7
        button.titleLabel?.layer.shadowOffset = CGSize(width: 4, height: 3)
        button.titleLabel?.layer.masksToBounds = false
        button.addTarget(self, action: #selector(playerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(watcherButton)
        mainView.addSubview(playerButton)
        addConstraints()
    }
    
    func handleAuthentication(){
        let context = LAContext()
        context.localizedFallbackTitle = "Please Use Passcode"
        
        var error: NSError?
        
        let reason = "Authentication required to access nerve"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                if success{
                    
                    DispatchQueue.main.async {
                        let cameraVC = CameraViewController()
                        let nav = UINavigationController(rootViewController: cameraVC)
                        nav.modalPresentationStyle = .fullScreen
                        self.present(nav, animated: true)
                    }
                    print("authorization worked")
                }
                else{
                    guard let error = error else {return}
                    print(error.localizedDescription)
                }
            }
        }
    }

    func addConstraints(){
        
        let mainViewConstraints = [
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
        ]
        
        let titleLabelConstraints = [
            titleLabel.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            titleLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7),
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor),
        ]
        
        let watcherButtonConstraints = [
            watcherButton.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.5),
            watcherButton.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.3),
            watcherButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            watcherButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor)
        ]
        
        let playerButtonConstraints = [
            playerButton.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.4),
            playerButton.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.3),
            playerButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            playerButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(mainViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(watcherButtonConstraints)
        NSLayoutConstraint.activate(playerButtonConstraints)
    }
    
    @objc func watcherButtonTapped(){
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.watcherButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.handleAuthentication()
        }
    }
    
    @objc func playerButtonTapped(){
        UIView.animate(withDuration: 1.0) { [weak self] in
            self?.playerButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.handleAuthentication()
        }
       
    }

}

