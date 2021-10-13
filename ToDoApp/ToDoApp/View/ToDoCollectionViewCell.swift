//
//  ToDoCollectionViewCell.swift
//  ToDoApp
//
//  Created by Darshan on 14/10/21.
//

import UIKit

class ToDoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblToDo:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 0.7
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }

}
