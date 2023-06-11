//
//  PlayListTableViewCell.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 11.06.2023.
//

import UIKit

final class PlayListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playListTitleLabel: UILabel!
    @IBOutlet weak var playListImageView: UIImageView!
    
    func setup(_ title: String, _ imageName: String) {
        playListImageView.image = UIImage(named: imageName)
        playListTitleLabel.text = title
    }
}
