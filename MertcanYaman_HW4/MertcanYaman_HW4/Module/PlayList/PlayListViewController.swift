//
//  PlayListViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 10.06.2023.
//

import UIKit

protocol PlayListViewControllerProtocol: AnyObject, BaseViewControllerProtocol{
    func setTableView()
    func reloadData()
    func playedSongHidden()
    func setPlayedSongView(_ music: (URL, String), _ index: Int)
}

final class PlayListViewController: BaseViewController {

    var presenter: PlayListPresenterProtocol!
    
    @IBOutlet weak var nextSongBtn: CircleButton!
    @IBOutlet weak var playSongBtn: CircleButton!
    @IBOutlet weak var previousSongBtn: CircleButton!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var playedSongView: UIView!
    @IBOutlet weak var playListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playedMusicShowUI(notification:)), name: Notification.Name("PlayedSong"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusicShowUI), name: Notification.Name("StopSong"), object: nil)
        
        let playSongTap = MyTapGesture(target: self, action: #selector(changeCircleBtn))
        playSongBtn.addGestureRecognizer(playSongTap)
        playSongTap.circleBtn = playSongBtn
        playSongTap.closure = {
            self.presenter.playMusic()
        }
        
        let nextSongTap = MyTapGesture(target: self, action: #selector(changeCircleBtn))
        nextSongBtn.addGestureRecognizer(nextSongTap)
        nextSongTap.circleBtn = nextSongBtn
        nextSongTap.closure = {
            self.presenter.nextSong()
        }
        
        let previousSongTap = MyTapGesture(target: self, action: #selector(changeCircleBtn))
        previousSongBtn.addGestureRecognizer(previousSongTap)
        previousSongTap.circleBtn = previousSongBtn
        previousSongTap.closure = {
            self.presenter.previousSong()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        presenter.fetchPlayList()
        
        nextSongBtn.layer.cornerRadius = nextSongBtn.bounds.width / 2
        nextSongBtn.layer.masksToBounds = true
        
        playSongBtn.layer.cornerRadius = playSongBtn.bounds.width / 2
        playSongBtn.layer.masksToBounds = true
        
        previousSongBtn.layer.cornerRadius = previousSongBtn.bounds.width / 2
        previousSongBtn.layer.masksToBounds = true
        
        
        playSongBtn.setup("play", "pause", UIColor(hexString: "#141921"), .white)
        nextSongBtn.setup("next", nil, UIColor(hexString: "#141921"), nil)
        previousSongBtn.setup("previous", nil, UIColor(hexString: "#141921"), nil)
        presenter.viewWillAppear()
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        presenter.goOtherScreen(.addPlayList)
    }

    
    @objc func playedMusicShowUI(notification: Notification) {
        guard let music = notification.userInfo?["song"] as? (String, String),
              let url = URL(string: music.0),
              let index = notification.userInfo?["index"] as? Int else { return }
        setPlayedSongView((url, music.1), index)
    }
    
    func setPlayedSongView(_ music: (URL, String), _ index: Int) {
        DispatchQueue.main.async {
            self.playedSongView.isHidden = false
            self.songImageView.sd_setImage(with: music.0)
            self.songTitle.text = music.1
            self.playSongBtn.selectNewIcon()
        }
    }
    
    @objc func stopMusicShowUI() {
        self.playSongBtn.selectDefaultIcon()
    }
    
    @objc func changeCircleBtn(sender : MyTapGesture) {
        sender.circleBtn.changeImageAndColor()
        guard let closure =  sender.closure else { return }
        closure()
    }
}

extension PlayListViewController: PlayListViewControllerProtocol {
    
    func playedSongHidden() {
        self.playedSongView.isHidden = true
    }
    
    func reloadData() {
        playListTableView.reloadData()
    }
    
    func setTableView() {
        playListTableView.delegate = self
        playListTableView.dataSource = self
        playListTableView.register(UINib(nibName: "PlayListTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayListTableViewCell")
    }
    
}

extension PlayListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPlayList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayListTableViewCell", for: indexPath) as! PlayListTableViewCell
        
        if indexPath.row == 0 {
            cell.setup("Your Favorites", "likeplaylist")
        }
        
        guard let playList = presenter.getPlayListByIndex(indexPath.row - 1) else { return cell }
        cell.setup(playList.name ?? "", "default")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presenter.goOtherScreen(.detailPlayList("Your Favorites"))
        }else {
            guard let playList = presenter.getPlayListByIndex(indexPath.row - 1) else { return }
            presenter.goOtherScreen(.detailPlayList(playList.name ?? ""))
        }
    }
    
}
