//
//  ViewController.swift
//  Конвертер валют
//
//  Created by Лера Тарасенко on 09.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let sendCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.text = "You send"
        label.textColor = #colorLiteral(red: 0.7182313204, green: 0.7208951712, blue: 0.8115698695, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sendCurrencyTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .numbersAndPunctuation
        textField.autocorrectionType = .no
        textField.font = UIFont.systemFont(ofSize: 28.0, weight: .regular)
        textField.addTarget(self, action: #selector(calculate), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let sendCurrencyButton: UIButton = {
        let button = UIButton()
        button.setTitle("USD", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.3628509641, green: 0.4177888036, blue: 0.8876214027, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.3628509641, green: 0.4177888036, blue: 0.8876214027, alpha: 1)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(changeCurrency(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let swapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.3628509641, green: 0.4177888036, blue: 0.8876214027, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(swapAction), for: .touchUpInside)
        return button
    }()
    
    let getCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.text = "They get"
        label.textColor = #colorLiteral(red: 0.7182313204, green: 0.7208951712, blue: 0.8115698695, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let getCurrencyResultLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let getCurrencyButton: UIButton = {
        let button = UIButton()
        button.setTitle("RUB", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.3628509641, green: 0.4177888036, blue: 0.8876214027, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.3628509641, green: 0.4177888036, blue: 0.8876214027, alpha: 1)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(changeCurrency(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var sendRate: Double {
        return viewModel.getCurrentRate(currency: sendCurrencyButton.titleLabel?.text ?? "")
    }
    
    private var getRate: Double {
        return viewModel.getCurrentRate(currency: getCurrencyButton.titleLabel?.text ?? "")
    }
    
    private var viewModel: ViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationContollerStyle()
        
        setupSubviews()
        
        viewModel = ViewModel()
        
        DispatchQueue.main.async {
            self.viewModel.fetchData()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        underLine(view: sendCurrencyTextField)
        underLine(view: getCurrencyResultLabel)
    }
    
    private func underLine<T: UIView>(view: T){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: view.frame.height - 1, width: view.frame.width, height: 1.0)
        bottomLine.backgroundColor = #colorLiteral(red: 0.8248457313, green: 0.8243528008, blue: 0.8847104907, alpha: 1).cgColor
        
        view.layer.addSublayer(bottomLine)
        view.layer.masksToBounds = true
    }
    
    private func setupNavigationContollerStyle(){
        title = "Currency сonverter"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3628509641, green: 0.4177888036, blue: 0.8876214027, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setupSubviews(){
        view.addSubview(sendCurrencyLabel)
        sendCurrencyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36).isActive = true
        sendCurrencyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sendCurrencyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28).isActive = true
        
        view.addSubview(sendCurrencyButton)
        sendCurrencyButton.topAnchor.constraint(equalTo: sendCurrencyLabel.bottomAnchor, constant: 20).isActive = true
        sendCurrencyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        sendCurrencyButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.addSubview(sendCurrencyTextField)
        sendCurrencyTextField.trailingAnchor.constraint(equalTo: sendCurrencyButton.leadingAnchor, constant: -33).isActive = true
        sendCurrencyTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28).isActive = true
        sendCurrencyTextField.centerYAnchor.constraint(equalTo: sendCurrencyButton.centerYAnchor).isActive = true
        
        view.addSubview(swapButton)
        swapButton.topAnchor.constraint(equalTo: sendCurrencyTextField.bottomAnchor, constant: 20).isActive = true
        swapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(getCurrencyLabel)
        getCurrencyLabel.topAnchor.constraint(equalTo: swapButton.topAnchor, constant: 20).isActive = true
        getCurrencyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        getCurrencyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28).isActive = true
        
        view.addSubview(getCurrencyButton)
        getCurrencyButton.topAnchor.constraint(equalTo: getCurrencyLabel.bottomAnchor, constant: 20).isActive = true
        getCurrencyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        getCurrencyButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.addSubview(getCurrencyResultLabel)
        getCurrencyResultLabel.trailingAnchor.constraint(equalTo: getCurrencyButton.leadingAnchor, constant: -33).isActive = true
        getCurrencyResultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28).isActive = true
        getCurrencyResultLabel.centerYAnchor.constraint(equalTo: getCurrencyButton.centerYAnchor).isActive = true
    }
    
    @objc func swapAction() {
        let supportingLet = sendCurrencyButton.titleLabel?.text
        sendCurrencyButton.setTitle(getCurrencyButton.titleLabel?.text, for: .normal)
        getCurrencyButton.setTitle(supportingLet, for: .normal)
        
        sendCurrencyTextField.text = getCurrencyResultLabel.text
        calculate()
    }
    
    @objc func calculate() {
        guard let sendValue = Double(sendCurrencyTextField.text ?? "") else { getCurrencyResultLabel.text = " "
            return }
        
        let getValue = sendValue / sendRate * getRate
        getCurrencyResultLabel.text = String(format: "%.2f", getValue)
    }
    
    @objc func changeCurrency(sender: UIButton) {
        changeCurrencyAlertController(sender: sender)
    }
    
    private func changeCurrencyAlertController(sender: UIButton){
        
        let alertController = UIAlertController(title: "Choose a currency",
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.setValue(NSAttributedString(string: "Choose a currency",
                                                    attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]),
                                 forKey: "attributedTitle")
        
        let height = NSLayoutConstraint(item: alertController.view!,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 0,
                                        constant: 344)
        let width = NSLayoutConstraint(item: alertController.view!,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 0,
                                       constant: 280)
        
        alertController.view.addConstraint(height)
        alertController.view.addConstraint(width)

        let tableView = TableView()
        tableView.separatorStyle = .none
        
        alertController.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 50).isActive = true
        tableView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -30).isActive = true
        tableView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -50).isActive = true
        
        DispatchQueue.main.async {
            tableView.viewModel = TableViewViewModel(dict: self.viewModel.getCurrencies())
            tableView.reloadData()
        }

        alertController.view.tintColor = #colorLiteral(red: 0.3628509641, green: 0.4177888036, blue: 0.8876214027, alpha: 1)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
            
            DispatchQueue.main.async {
                guard let title = tableView.viewModel?.getSelectedTitle() else { return }
                sender.setTitle(title, for: .normal)
                self.calculate()
            }
            
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

