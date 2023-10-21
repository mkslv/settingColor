//
//  ViewController.swift
//  Colorizer
//
//  Created by Max Kiselyov on 10/18/23.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: properties
    var selectedColor = UIColor(.indigo)
    weak var delegate: SettingViewControllerDelegate!
    private var activeTextField: UITextField?
    
    private let colorView = UIView()
    
    private let redLabel = UILabel()
    private let greenLabel = UILabel()
    private let blueLabel = UILabel()

    private let redTextField = UITextField()
    private let greenTextField = UITextField()
    private let blueTextField = UITextField()
    
    private let redSlider = UISlider()
    private let greenSlider = UISlider()
    private let blueSlider = UISlider()
    
    private let redContainer = UIStackView()
    private let greenContaineer = UIStackView()
    private let blueContainer = UIStackView()
    
    private let mainContainer = UIStackView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Methods
    @objc
    func sliderValueChanged() {
        setupTextFieldsValue()
        updateSelectedColor()
        setupColorView()
    }
    
    @objc
    func applyColor() {
        // здесь обращаемся к методу делегата что бы передать и обновить цвет
        delegate.applyColor(color: selectedColor)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func textFieldValueChanged() {
        updateSliderValueByTextField()
        updateSelectedColor()
        setupColorView()
    }
    
    @objc func handleTap() {
        // Resign the first responder from the active text field
        activeTextField?.resignFirstResponder()
    }
}

// MARK: - Setup view
private extension SettingsViewController {
    func setupView() {
        addSubviews()
        setupMainView()
        setupColorView()
        setupLabels()
        setupTextFields()
        setupSliders()
        setupTextFieldsValue()

        createHorizontalContainer(with: redContainer, label: redLabel, textField: redTextField, slider: redSlider)
        createHorizontalContainer(with: greenContaineer, label: greenLabel, textField: greenTextField, slider: greenSlider)
        createHorizontalContainer(with: blueContainer, label: blueLabel, textField: blueTextField, slider: blueSlider)
        createVerticalContainer()
        createOKButton()
        
        setupLayout()
    }
}

// MARK: - Settings
private extension SettingsViewController {
    
    func addSubviews() {
        [mainContainer].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    func setupMainView() {
        view.backgroundColor = Theme.mainColor
        
        title = "Pick a screen color"
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        // Add a tap gesture recognizer to the view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupColorView() {
        colorView.backgroundColor = selectedColor
        
        colorView.layer.borderColor = Theme.accentColor.cgColor
        colorView.layer.borderWidth = 1
        colorView.layer.cornerRadius = 15
    }
    
    func setupLabels() {
        redLabel.text = "Red"
        greenLabel.text = "Green"
        blueLabel.text = "Blue"
    }
    
    func setupTextFields() {
        redTextField.keyboardType = .decimalPad
        greenTextField.keyboardType = .decimalPad
        blueTextField.keyboardType = .decimalPad

        redTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        greenTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        blueTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)

    }
    
    func setupSliders() {
        redSlider.minimumTrackTintColor = .red
        redSlider.maximumTrackTintColor = .red.withAlphaComponent(0.3)
        
        greenSlider.minimumTrackTintColor = .systemGreen
        greenSlider.maximumTrackTintColor = .systemGreen.withAlphaComponent(0.3)
        
        blueSlider.minimumTrackTintColor = .systemBlue
        blueSlider.maximumTrackTintColor = .systemBlue.withAlphaComponent(0.3)
        
        let ciColor = CIColor(color: selectedColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
        
        [redSlider, greenSlider, blueSlider].forEach { slider in
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        }
    }
    
    func setupTextFieldsValue() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    func updateSelectedColor() {
        selectedColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
    }
    
    func createHorizontalContainer(
        with container: UIStackView,
        label: UILabel,
        textField: UITextField,
        slider: UISlider
    ) {
        container.axis = .horizontal
        container.distribution = .equalSpacing
        [label, textField, slider].forEach { subView in
            container.addArrangedSubview(subView)
        }
    }
    
    func createVerticalContainer() {
        mainContainer.axis = .vertical
        mainContainer.spacing = 20
        [colorView, redContainer, greenContaineer, blueContainer].forEach { subView in
            mainContainer.addArrangedSubview(subView)
        }
    }
    
    // FIXME: put in delegate
    func updateSliderValueByTextField() {
        if let text = redTextField.text, let value = Float(text) {
            redSlider.value = value
        }
        if let text = greenTextField.text, let value = Float(text) {
            greenSlider.value = value
        }
        if let text = blueTextField.text, let value = Float(text) {
            blueSlider.value = value
        }
    }
    
    func createOKButton() {
        let okButton = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyColor))
        navigationItem.rightBarButtonItems = [okButton]
    }
}

// MARK: - Layout
private extension SettingsViewController {
    func setupLayout() {
        [mainContainer].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor, multiplier: 0.5),
            
            redSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60),
            greenSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60),
            blueSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60),
            
            redLabel.widthAnchor.constraint(equalTo: greenLabel.widthAnchor),
            blueLabel.widthAnchor.constraint(equalTo: greenLabel.widthAnchor),
        ])
    }
}

// MARK: - TextField Delegate
extension SettingsViewController: UITextFieldDelegate {
    // validation of input: 0.0 - 1.0
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Combine the current text and the replacement text
        let currentText = textField.text ?? "0.0"
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
        // Convert the updated text to a Double
        if let inputValue = Double(updatedText) {
            // Check if the input value is within the range [0.0, 1.0]
            if (0.0...1.0).contains(inputValue) {
                return true // Allow the input
            }
        }
        // If the input is not valid, prevent it
        return false
    }
    
    // Implement UITextFieldDelegate method to track the active text fields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit() // По- сути добавляет над клавой бар
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        // TODO: Записать в нотс
        let flexBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButtonItem, doneButton]
        
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
        
        // check format of textLabel according to %.2f
        setupTextFieldsValue()
    }
}


