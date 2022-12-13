//
//  SettingsViewController.swift
//  RGBslider
//
//  Created by Philip Noskov on 22.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    // MARK: - Public Properties
    
    var delegate: SettingsViewControllerDelegate!
    var color: UIColor!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = color
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        setupUI()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            redLabel.text = string(from: sender)
            redTF.text = string(from: sender)
        case 2:
            greenLabel.text = string(from: sender)
            greenTF.text = string(from: sender)
        default:
            blueLabel.text = string(from: sender)
            blueTF.text = string(from: sender)
        }
        setupColorView()
    }
    
    @IBAction func saveButtonPressed() {
        delegate.setColor(from: colorView)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        setupLabels(for: redLabel, greenLabel, blueLabel)
        setupTF(for: redTF, greenTF, blueTF)
        
    }
    
    private func setupLabels(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setupTF(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF: textField.text = string(from: redSlider)
            case greenTF: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setupColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
            )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {

    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        textField?.text = ""
    }
     alert.addAction(okAction)
     present(alert, animated: true)
    }

}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
        if 0...1 ~= numberValue {
            switch textField {
            case redTF:
                redSlider.value = numberValue
                setupLabels(for: redLabel)
            case greenTF:
                greenSlider.value = numberValue
                setupLabels(for: greenLabel)
            default:
                blueSlider.value = numberValue
                setupLabels(for: blueLabel)
            }
            setupColorView()
        } else {
            showAlert(title: "Error!", message: "Please enter a number from 0 to 1", textField: textField)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keypadToolbar = UIToolbar()
        textField.inputAccessoryView = keypadToolbar
        keypadToolbar.sizeToFit()

        keypadToolbar.items=[
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                title: "Done",
                style: .done,
                target: textField,
                action: #selector(UITextField.resignFirstResponder)
            )
        ]
    }

}
