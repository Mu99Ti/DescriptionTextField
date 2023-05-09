//
//  ViewController.swift
//  TextView
//
//  Created by Muhamad Talebi on 5/9/23.
//

import UIKit

class ViewController: UIViewController {

    private let charsLimit = 2000
    private let minimumCharLimit = 20
    
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
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configure()
        configureText(maximumChars: charsLimit, minimumChar: minimumCharLimit)
        
        view.addSubview(descriptionView)
        descriptionView.addSubview(textView)
        view.addSubview(charactersLimitLabel)
        view.addSubview(alertLabel)
        
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionView.heightAnchor.constraint(equalToConstant: 200),
            descriptionView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            charactersLimitLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            charactersLimitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            alertLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            alertLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
    }
}

extension ViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var state: TextState?
        let text = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = text.count
        charactersLimitLabel.text = "\(numberOfChars)/\(charsLimit)"
        if numberOfChars >= minimumCharLimit {
            state = .valid
        } else {
            state = .invalid
        }
        textFieldConfigure(state)
        charactersLimitLabel.text = "\(numberOfChars)/\(charsLimit)"
        // we should call textViewDidChange after all of steps in shouldChangeTextIn for updating numberCounter coorectly
        textViewDidChange(textView)
        return numberOfChars < charsLimit
    }
    
    func textFieldConfigure(_ state: TextState?) {
        switch state {
        case .invalid:
            textView.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.7).cgColor
            alertLabel.text = "Length of description cannot be less than \(minimumCharLimit)"
        case .valid:
            textView.layer.borderColor = UIColor.init(red: 0.31, green: 0.71, blue: 0.76, alpha: 1).cgColor
            alertLabel.isHidden = true
        case .none:
            break
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text.count
        charactersLimitLabel.text = "\(textCount)/\(charsLimit)"
        debugPrint("numbber of chcracters are: \(textCount)")
    }
    
}

extension ViewController {
    
    enum TextState {
        case valid
        case invalid
    }
}

extension ViewController {
    
    private func configure() {
        textView.backgroundColor = .systemBackground
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1.0
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.7).cgColor
        textView.delegate = self.self
        charactersLimitLabel.textColor = .systemGray.withAlphaComponent(0.5)
        charactersLimitLabel.textColor = .systemGray
        charactersLimitLabel.font = UIFont(name: "Arial", size: 12)
        charactersLimitLabel.adjustsFontSizeToFitWidth = true
        alertLabel.textColor = UIColor.systemRed.withAlphaComponent(0.7)
        alertLabel.font = UIFont(name: "Arial", size: 12)
        alertLabel.minimumScaleFactor = 0.7
        alertLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureText(maximumChars: Int, minimumChar: Int? = nil) {
        charactersLimitLabel.text = "0/\(maximumChars)"
        alertLabel.text = "Length of description cannot be less than \(minimumCharLimit)"
    }
}
