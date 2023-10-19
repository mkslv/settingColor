//
//  InitialViewController.swift
//  Colorizer
//
//  Created by Max Kiselyov on 10/19/23.
//

import UIKit

class InitialViewController: UIViewController {
    // MARK: Properties
    var selectedColor = UIColor(_colorLiteralRed: 0.79, green: 0.9, blue: 0.99, alpha: 1.0)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Methods
    @objc
    func settingButtonTapped() {
        let destinationViewController = SettingsViewController()
        destinationViewController.selectedColor = selectedColor
        navigationController?.pushViewController(destinationViewController, animated: true)
        
        // тут инициализируем экземпляр нашего делегата
        destinationViewController.delegate = self
    }
}

// MARK: - Setting View
private extension InitialViewController {
    func setupView() {
        addSubviews()
        
        setupSetupColorButton()
        setingLayout()
    }
}

// MARK: - Settings
private extension InitialViewController {
    func addSubviews() {
        view.backgroundColor = selectedColor
    }
    
    func setupSetupColorButton() {
        let setupButton = UIBarButtonItem(image: UIImage.init(systemName: "gear"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.rightBarButtonItem = setupButton
    }
}

// MARK: - Layout
private extension InitialViewController {
    func setingLayout() {
        
    }
}

// MARK: - Subscribe delegate
// Подписываемся под делегатом 
extension InitialViewController: SettingViewControllerDelegate {
    func applyColor(color: UIColor) {
        selectedColor = color
        view.backgroundColor = color
    }
}
