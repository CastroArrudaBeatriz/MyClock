//
//  IntroductionViewController.swift
//  MyClock
//
//  Created by Beatriz Castro on 26/04/21.
//

import UIKit

class DefaultPageViewController: UIViewController {
    var page: Page

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.textAlignment = .justified
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.text = page.title
        return titleLabel
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: page.image)
        return image
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Iniciar", for: .normal)
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(goToTimerViewController), for: .touchUpInside)
        return button
    }()

    init(with page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
        ])
    
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -70.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
        ])
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60.0),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
        ])
        
    }
    
    @objc
    private func goToTimerViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timerViewController = storyboard.instantiateViewController(identifier: "ViewController")
        timerViewController.modalPresentationStyle = .fullScreen
        show(timerViewController, sender: self)
    }
}
