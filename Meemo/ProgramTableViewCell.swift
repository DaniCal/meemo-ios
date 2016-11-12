//
//  ProgramTableViewCell.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/11/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle(_ title: String){
        titleLabel.text = title
    }
    
    func setSubtitle(_ subtitle: String){
        descriptionLabel.text = subtitle
    }


}
