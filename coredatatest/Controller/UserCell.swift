//
//  UserCell.swift
//  ChatApp
//
//  Created by Park Chan on 2018. 7. 18..
//  Copyright © 2018년 Park Chan. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func primaryColor() -> UIColor {
        return UIColor(r: 149, g: 188, b: 249)
    }
}

class UserCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let textBubble: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 10
        tv.layer.masksToBounds = true
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        tv.textColor = UIColor.black
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        tv.isEditable = false
        tv.isSelectable = false
        tv.isUserInteractionEnabled = false
        
        return tv
    }()
    
    let musicButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "music")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(img, for: .normal)
        btn.backgroundColor = UIColor.clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let selectedButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "checked")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(img, for: .normal)
        btn.tintColor = UIColor(r: 220, g: 220, b: 220)
        btn.backgroundColor = UIColor.clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    var textWidthAnchor: NSLayoutConstraint?
    var textHeightAnchor: NSLayoutConstraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(textBubble)
        addSubview(musicButton)
        addSubview(selectedButton)
        
        // set profileImageView
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // set profile name view
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // set profile message bubble
        textBubble.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        textBubble.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textWidthAnchor = textBubble.widthAnchor.constraint(equalToConstant: 200)
        textWidthAnchor?.isActive = true
        textHeightAnchor = textBubble.heightAnchor.constraint(equalToConstant: 60)
        textHeightAnchor?.isActive = true
        
        // set music button
        musicButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        musicButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        musicButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        musicButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // set checked button : default hidden
        selectedButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32).isActive = true
        selectedButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectedButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        selectedButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        selectedButton.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
}
