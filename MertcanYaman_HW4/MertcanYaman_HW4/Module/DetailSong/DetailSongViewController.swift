//
//  DetailSongViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import UIKit
import SDWebImage

protocol DetailSongViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
    func reloadData()
    func setupData(_ imageUrl: URL, _ title: String, _ artist: String)
}

final class DetailSongViewController: BaseViewController {
    
    var presenter: DetailSongPresenterProtocol!
    
    @IBOutlet weak var nextCircleBtn: CircleButton!
    @IBOutlet weak var saveSongView: CircleButton!
    @IBOutlet weak var playCircleBtn: CircleButton!
    @IBOutlet weak var previousMusicBtn: CircleButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var innerImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(backTap)
        
        let saveSongTap = MyTapGesture(target: self, action: #selector(changeCircleBtn))
        saveSongView.addGestureRecognizer(saveSongTap)
        saveSongTap.circleBtn = saveSongView
        saveSongTap.closure = {
            self.presenter.saveMusicFromCoreData()
        }
        
        let playSongTap = MyTapGesture(target: self, action: #selector(changeCircleBtn))
        playCircleBtn.addGestureRecognizer(playSongTap)
        playSongTap.circleBtn = playCircleBtn
        playSongTap.closure = {
            self.presenter.fetchSavedMusicFromCoreData()
        }
        
        let nextSongTap = MyTapGesture(target: self, action: #selector(changeCircleBtn))
        nextCircleBtn.addGestureRecognizer(nextSongTap)
        nextSongTap.circleBtn = nextCircleBtn
        
        let previousSongTap = MyTapGesture(target: self, action: #selector(changeCircleBtn))
        previousMusicBtn.addGestureRecognizer(previousSongTap)
        previousSongTap.circleBtn = previousMusicBtn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
        self.navigationController?.isNavigationBarHidden = true
        self.title = "Mertcan"
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowRadius = 6
        shadowView.layer.shadowOpacity = 1
        
        previousMusicBtn.layer.cornerRadius = previousMusicBtn.bounds.width / 2
        previousMusicBtn.layer.masksToBounds = true
        
        playCircleBtn.layer.cornerRadius = playCircleBtn.bounds.width / 2
        playCircleBtn.layer.masksToBounds = true
        
        saveSongView.layer.cornerRadius = saveSongView.bounds.width / 2
        saveSongView.layer.masksToBounds = true
        
        nextCircleBtn.layer.cornerRadius = nextCircleBtn.bounds.width / 2
        nextCircleBtn.layer.masksToBounds = true
        
        previousMusicBtn.setup("previous", nil, UIColor(hexString: "#141921"), nil)
        playCircleBtn.setup("play", "pause", UIColor(hexString: "#141921"), .white)
        saveSongView.setup("emptyheart", "fillheart", UIColor(hexString: "#141921"), nil)
        nextCircleBtn.setup("next", nil, UIColor(hexString: "#141921"), nil)
    }
    
    func setImage(_ url: URL) {
        self.innerImageView.sd_setImage(with: url)
    }
    
    func setSongName(_ songName: String) {
        self.songNameLabel.text = songName
    }
    
    func setArtistName(_ artistName: String) {
        self.artistNameLabel.text = artistName
    }
    
    @objc func back() {
        self.presenter.goPreviousScreen()
    }
    
    @objc func changeCircleBtn(sender : MyTapGesture) {
        sender.circleBtn.changeImageAndColor()
        guard let closure =  sender.closure else { return }
        closure()
    }
}

extension DetailSongViewController: DetailSongViewControllerProtocol {
    
    func reloadData() {
        
    }
    
    func setupData(_ imageUrl: URL, _ title: String, _ artist: String) {
        self.setImage(imageUrl)
        self.setSongName(title)
        self.setArtistName(artist)
    }   
    
}

class MyTapGesture: UITapGestureRecognizer {
    var circleBtn = CircleButton()
    var closure: (()->Void)?
}
