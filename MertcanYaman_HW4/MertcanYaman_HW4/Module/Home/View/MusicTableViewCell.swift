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
    
    func setup(_ image: URL?,_ title: String,_ content: String, _ index: Int, _ trackId: Int) {
        songImageView.sd_setImage(with: image)
        songTitleLabel.text = title
        contentTitleLabel.text = content
        self.index = index
        if PlaySong.shared.checkPlayedEqualIsThisSong(trackId) {
            isStartedMusic = true
            self.playButton.imageView?.image = UIImage(named: "pausewhite")
        }else {
            isStartedMusic = false
            self.playButton.imageView?.image = UIImage(named: "play")
        }
    }
    
    @IBAction func playBtnClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("OtherMusicListStarted"), object: nil)
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
}
