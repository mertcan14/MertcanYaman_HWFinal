//
//  MusicTableViewCell.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import UIKit
import SDWebImage

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    func setup(_ image: URL?,_ title: String,_ content: String) {
        songImageView.sd_setImage(with: image)
        songTitleLabel.text = title
        contentTitleLabel.text = content
    }
    
}
