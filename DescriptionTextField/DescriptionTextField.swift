//
//  DescriptionTextField.swift
//  TextView
//
//  Created by Muhamad Talebi on 5/9/23.
//

import UIKit

class DescriptionTextField: UIView, UITextViewDelegate {
    
    private let maximumCharsLimit  = 2000
    private let minimumCharsLimit = 20
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var charactersLimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func textFieldConfigure(_ state: TextState?) {
        switch state {
        case .invalid:
            textView.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.7).cgColor
        case .valid:
            textView.layer.borderColor = UIColor.init(red: 0.31, green: 0.71, blue: 0.76, alpha: 1).cgColor
            errorLabel.isHidden = true
        case .none:
            break
        }
    }
    
    private func configure() {
        textView.backgroundColor = .systemBackground
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1.0
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.7).cgColor
        textView.delegate = self.self
        charactersLimitLabel.font = UIFont(name: "Arial", size: 12)
        charactersLimitLabel.textColor = .systemGray.withAlphaComponent(0.5)
        charactersLimitLabel.adjustsFontSizeToFitWidth = true
        errorLabel.font = UIFont(name: "Arial", size: 12)
        errorLabel.textColor = UIColor.systemRed.withAlphaComponent(0.7)
        errorLabel.minimumScaleFactor = 0.7
        errorLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureText(maximumChars: Int, minimumChar: Int? = nil) {
        charactersLimitLabel.text = "0/\(maximumChars)"
        errorLabel.text = "Length of description cannot be less than \(minimumCharsLimit)"
    }
    
    //MARK: UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text.count
        charactersLimitLabel.text = "\(textCount)/\(maximumCharsLimit)"
    }
    
    //MARK: UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var state: TextState?
        let text = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = text.count
        
        if numberOfChars > minimumCharsLimit {
            state = .valid
        } else {
            state = .invalid
        }
        
        textFieldConfigure(state)
        textViewDidChange(textView)
        
        return numberOfChars < maximumCharsLimit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureText(maximumChars: maximumCharsLimit, minimumChar: minimumCharsLimit)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: self.bottomAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            charactersLimitLabel.topAnchor.constraint(equalTo: self.bottomAnchor),
            charactersLimitLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptionTextField {
    enum TextState {
        case valid
        case invalid
    }
}
