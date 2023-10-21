//
//  InitialViewController.swift
//  Colorizer
//
//  Created by Max Kiselyov on 10/19/23.
//

import UIKit

final class InitialViewController: UIViewController {
    // MARK: Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Methods
    @objc
    func settingButtonTapped() {
        let destinationViewController = SettingsViewController()
        destinationViewController.selectedColor = view.backgroundColor! // FIXME: Force unwrap
        navigationController?.pushViewController(destinationViewController, animated: true)
        
        // тут инициализируем экземпляр нашего делегата
        destinationViewController.delegate = self
    }
}

// MARK: - Setting View
private extension InitialViewController {
    func setupView() {
        setColorOfView()
        
        setupSetupColorButton()
    }
}

// MARK: - Settings
private extension InitialViewController {
    func setColorOfView() {
        view.backgroundColor = Theme.mainColor
    }
    
    func setupSetupColorButton() {
        let setupButton = UIBarButtonItem(image: UIImage.init(systemName: "gear"), style: .plain, target: self, action: #selector(settingButtonTapped))
        navigationItem.rightBarButtonItem = setupButton
    }
}

// MARK: - Subscribe delegate
// Подписываемся под делегатом 
extension InitialViewController: SettingViewControllerDelegate {
    func applyColor(color: UIColor) {
        view.backgroundColor = color
    }
}
