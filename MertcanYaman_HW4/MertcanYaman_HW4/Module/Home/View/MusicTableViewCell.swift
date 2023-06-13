//
//  MusicTableViewCell.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import UIKit
import SDWebImage

class MusicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    var isStartedMusic: Bool = false
    var index: Int = 0
    
    func setup(_ image: URL?,_ title: String,_ content: String, _ index: Int) {
        songImageView.sd_setImage(with: image)
        songTitleLabel.text = title
        contentTitleLabel.text = content
        self.index = index
        if index == PlaySong.shared.getIndex() && PlaySong.shared.isPlay() {
            isStartedMusic = true
            self.playButton.imageView?.image = UIImage(named: "pausewhite")
        }else {
            isStartedMusic = false
            self.playButton.imageView?.image = UIImage(named: "play")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.otherSongPlay(notification:)), name: Notification.Name("PlayedSong"), object: nil)
    }
    
    @IBAction func playBtnClicked(_ sender: Any) {
        if !isStartedMusic {
            DispatchQueue.main.async {
                self.playButton.imageView?.image = UIImage(named: "pausewhite")
            }
            PlaySong.shared.startSong(self.index)
            self.isStartedMusic = true
        }else {
            DispatchQueue.main.async {
                self.playButton.imageView?.image = UIImage(named: "play")
            }
            PlaySong.shared.stopSong()
            self.isStartedMusic = false
        }
    }
    
    @objc func otherSongPlay(notification: Notification) {
        guard let playIndex = notification.userInfo?["index"] as? Int else { return }
        if self.index != playIndex {
            DispatchQueue.main.async {
                self.playButton.imageView?.image = UIImage(named: "play")
            }
            self.isStartedMusic = false
        }
    }
}
