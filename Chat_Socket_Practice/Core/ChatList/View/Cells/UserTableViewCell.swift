//
//  UserTableViewCell.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 12/09/2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    //MARK: - UIViews
    var titleLabel: UILabel = {
       var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    var onlineIcon: UIImageView = {
        let imageView = UIImageView()
        if #available(iOS 15.0, *) {
            imageView.image = UIImage(systemName: "circle.fill",withConfiguration: UIImage.SymbolConfiguration(paletteColors: [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]))
        } else {
            // Fallback on earlier versions
        }
        return imageView
    }()
    
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(onlineIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 10, y: 20, width: contentView.frame.width, height: 18)
        onlineIcon.frame = CGRect(x: contentView.frame.width - 30, y: 20, width: 12, height: 12)
    }
    
    
    //MARK: - Helpers
    func config(_ user: UserModel){
        titleLabel.text = user.nickname
    }

    //MARK: - Cell Config
    static let identifier: String = "UserTableViewCell"
}
