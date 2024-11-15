//
//  MessagesTableViewCell.swift
//  homework8
//
//  Created by Christina Kang on 11/12/24.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelText: UILabel!
    var labelDateAndTime: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelText()
        setupLabelDateAndTime()
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
     
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 13)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = UIFont.boldSystemFont(ofSize: 17)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelText)
    }
    
    func setupLabelDateAndTime(){
        labelDateAndTime = UILabel()
        labelDateAndTime.font = UIFont.boldSystemFont(ofSize: 11)
        labelDateAndTime.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDateAndTime)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelName.heightAnchor.constraint(equalToConstant: 16),
            labelName.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            labelText.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelText.heightAnchor.constraint(equalToConstant: 20),
            labelText.widthAnchor.constraint(equalTo: labelName.widthAnchor),
            
            labelDateAndTime.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            labelDateAndTime.leadingAnchor.constraint(equalTo: labelText.leadingAnchor),
            labelDateAndTime.heightAnchor.constraint(equalToConstant: 16),
            labelDateAndTime.widthAnchor.constraint(equalTo: labelText.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 80),
        
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
