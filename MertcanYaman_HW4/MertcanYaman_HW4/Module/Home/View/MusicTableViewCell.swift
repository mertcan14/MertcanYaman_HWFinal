//
//  MusicTableViewCell.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import UIKit

protocol MusicTableViewCellProtocol: AnyObject {
    
    func setImage(_ image: URL)
    func setTitle(_ text: String)
    func setArtist(_ text: String)
    func setButton(_ bool: Bool)
    
}

final class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    var cellPresenter: MusicTableViewCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    @IBAction func playBtnClicked(_ sender: Any) {
        cellPresenter.playSongTap()
    }
    
}

extension MusicTableViewCell: MusicTableViewCellProtocol {
    
    func setButton(_ bool: Bool) {
        if bool {
            DispatchQueue.main.async {
                self.playButton.imageView?.image = UIImage(named: "pausewhite")
            }
        }else {
            DispatchQueue.main.async {
                self.playButton.imageView?.image = UIImage(named: "play")
            }
        }
    }
    
    func setImage(_ image: URL) {
        songImageView.sd_setImage(with: image)
    }
    
    func setTitle(_ text: String) {
        songTitleLabel.text = text
    }
    
    func setArtist(_ text: String) {
        contentTitleLabel.text = text
    }
    
}
