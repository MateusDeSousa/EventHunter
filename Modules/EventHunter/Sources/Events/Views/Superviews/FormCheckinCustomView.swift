//
//  FormCheckinCustomView.swift
//  EventHunter
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit
import mCore
import Lottie

protocol FormCheckinCustomViewDelegate {
    func closeButtonPressed()
    func nameFieldDidChange(_ text: String)
    func emailFieldDidChange(_ text: String)
    func doneButtonPressed()
}

class FormCheckinCustomView: UIView, UITextFieldDelegate {
    
    private let closeButton: CircleButtonView = {
        let button = CircleButtonView()
        button.setup(type: .close)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Insira seus dados abaixo para continuar com o check-in"
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .labelColor
        label.numberOfLines = 0
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Nome"
        textField.returnKeyType = .next
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-mail"
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        return textField
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Concluir", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.cornerRadius(of: 12)
        return button
    }()
    
    private lazy var animationCheckView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.animation = Animation.named("checking")
        animation.loopMode = .playOnce
        return animation
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.backgroundColor = .cardBackgroundColor
        return view
    }()
    
    var delegate: FormCheckinCustomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        addSubviews()
        setupAnchors()
        closeButton.setPositionTopLeft()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
    
    private func setupSubviews() {
        backgroundColor = .cardBackgroundColor
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nameTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.delegate = self
        doneButton.addTarget(self, action: #selector(onTapDoneButton), for: .touchUpInside)
    }
    
    @objc private func onTapDoneButton() {
        endEditing(true)
        delegate?.doneButtonPressed()
    }
    
    private func addSubviews() {
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(doneButton)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            doneButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            doneButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 180),
            doneButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc public func textFieldDidChange(_ sender: UITextField) {
        if sender == nameTextField {
            delegate?.nameFieldDidChange(sender.text!)
        }else {
            delegate?.emailFieldDidChange(sender.text!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            emailTextField.resignFirstResponder()
            delegate?.doneButtonPressed()
        default:
            break
        }
        return true
    }
    
    public func startCompleteCheckin() {
        addSubview(blackView)
        blackView.addSubview(animationCheckView)
        NSLayoutConstraint.activate([
            blackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blackView.topAnchor.constraint(equalTo: topAnchor),
            blackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            animationCheckView.centerXAnchor.constraint(equalTo: blackView.centerXAnchor),
            animationCheckView.centerYAnchor.constraint(equalTo: blackView.centerYAnchor),
            animationCheckView.heightAnchor.constraint(equalToConstant: 200),
            animationCheckView.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.blackView.alpha = 1
        } completion: {[weak self] _ in
            self?.animationCheckView.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.delegate?.closeButtonPressed()
            }
        }
    }
}
