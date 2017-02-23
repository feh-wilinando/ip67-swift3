//
//  ContatoTableViewCell.swift
//  Contato
//
//  Created by Nando on 08/11/16.
//  Copyright © 2016 Nando. All rights reserved.
//

import UIKit

class ContatoTableViewCell: UITableViewCell {

    
    @IBOutlet var fotoImageView: UIImageView!
    @IBOutlet var nomeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.fotoImageView.layer.cornerRadius = 25.0
        self.fotoImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
