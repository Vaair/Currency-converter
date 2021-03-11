//
//  TableViewCell.swift
//  Конвертер валют
//
//  Created by Лера Тарасенко on 10.03.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseId = "TableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectedImageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = #colorLiteral(red: 0.3628509641, green: 0.4177888036, blue: 0.8876214027, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    weak var viewModel: TableViewCellViewModelProtocol? {
        willSet(viewModel){
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
        }
    }
      
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        if selected{
            selectedImageIcon.image = UIImage(systemName: "largecircle.fill.circle")
        } else{
            selectedImageIcon.image = UIImage(systemName: "circle")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
       
        selectionStyle = .none
        
        addSubview(selectedImageIcon)
        selectedImageIcon.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        selectedImageIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        selectedImageIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        selectedImageIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: selectedImageIcon.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: selectedImageIcon.trailingAnchor, constant: 26).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
