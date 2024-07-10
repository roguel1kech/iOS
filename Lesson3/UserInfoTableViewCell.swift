//
//  UserInfoTableViewCell.swift
//  asd
//
//  Created by Айнур Салахутдинов on 08.07.2024.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    private lazy var previousImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
//   
    private lazy var  developerInfoLabel : UILabel = {
        let developerInfoLabel = UILabel()
        developerInfoLabel.textColor = UIColor(named: "textcolor")
        developerInfoLabel.numberOfLines = 0
        developerInfoLabel.textAlignment = .center
        developerInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        return developerInfoLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        addSubview(previousImageView)
        addSubview(developerInfoLabel)
        
        NSLayoutConstraint.activate([
            previousImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            previousImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            previousImageView.heightAnchor.constraint(equalToConstant: 60),
            previousImageView.widthAnchor.constraint(equalToConstant: 60),
            developerInfoLabel.centerYAnchor.constraint(equalTo:safeAreaLayoutGuide.centerYAnchor ),
            developerInfoLabel.leadingAnchor.constraint(equalTo: previousImageView.trailingAnchor, constant: 16),
            developerInfoLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
    }
    func configure(with developer: Developer) {
        developerInfoLabel.text = "@\(developer.title)\n\(developer.name)\nEmail: \(developer.email)"
        previousImageView.image = developer.photo
    }
    
    override func prepareForReuse() {
        developerInfoLabel.text = nil
        previousImageView.image = nil
    }
    static var reuseIdentifier = "developerCellId"
        
    
}
