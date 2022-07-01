//
//  ViewController.swift
//  DogRandomizer
//
//  Created by Vanda S. on 01/07/2022.
//

import UIKit

class ViewController: UIViewController {

    var image: UIImageView?
    var button: UIButton?
    var label: UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpImageView()
        setUpLabel()
        setUpButton()
        setUpShareButton()
    }

    func setUpImageView() {
        image = UIImageView()
        image!.layer.backgroundColor = UIColor.systemBackground.cgColor
        image!.layer.cornerRadius = 10
        image!.contentMode = .scaleAspectFit
        image!.clipsToBounds = true
        view.addSubview(image!)
        
        image!.translatesAutoresizingMaskIntoConstraints = false
        image!.heightAnchor.constraint(equalTo: image!.widthAnchor, multiplier: 3.0/1.0).isActive = true
        image!.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image!.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image!.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 20).isActive = true
        image!.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -20).isActive = true
    }
    
    func setUpLabel() {
        let label = UILabel()
        label.text = "Dog randomizer"
        label.textColor = UIColor(named: "labelColor")
        label.font = UIFont(name: "Kohinoor Bangla Semibold", size: 30)
        label.textAlignment = .center
       
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: image!.topAnchor, constant: -50).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setUpButton() {
        let button = UIButton(type: .system)
        
        button.setTitle("Randomize a dog", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont(name: "Kohinoor Bangla Semibold", size: 25)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "buttonColor")

        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: image!.bottomAnchor, constant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -30).isActive = true
        button.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -20).isActive = true
        button.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 20).isActive = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setUpShareButton() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePicture))
        shareButton.tintColor = UIColor(named: "labelColor")
        navigationItem.rightBarButtonItem = shareButton
    }

    @objc func sharePicture() {
        guard let image = dogImage?.jpegData(compressionQuality: 0.8) else {
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        fetchDog { [weak self] dog in
            dogImage = dog
            DispatchQueue.main.async {
                self?.image?.image = dog
            }
            
        }
        
    }}

