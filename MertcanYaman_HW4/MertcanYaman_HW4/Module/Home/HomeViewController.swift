//
//  HomeViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
    
    func reloadData()
    func setupField()
    func setupTableView()
    func setWillAppear()
    func hiddenPlayedSong(_ bool: Bool)
    func reloadDataNotification()
    func setupNotificationCenter()
    func setupGestureRecognizer()
    func setupCircleButton()
    
}

final class HomeViewController: BaseViewController {
    
    var timer: Timer?
    var presenter: HomePresenterProtocol!
    
    @IBOutlet weak var nextSongBtn: CircleButton!
    @IBOutlet weak var playSongBtn: CircleButton!
    @IBOutlet weak var previousSongBtn: CircleButton!
    @IBOutlet weak var playedSongTitle: UILabel!
    @IBOutlet weak var playedSongImage: UIImageView!
    @IBOutlet weak var playedSong: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarTxt: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setAccessiblityIdentifier()
        self.presenter.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter.viewWillAppear()
        
    }
    
    func setPlayedSongView() {
        
        guard let music = PlaySong.shared.getMusicForTableCellByIndex(),
              let url = URL(string: music.0) else { return }
        DispatchQueue.main.async {
            self.playedSong.isHidden = false
            self.playedSongImage.sd_setImage(with: url)
            self.playedSongTitle.text = music.1
        }
        
    }
    
    @objc func changeCircleBtn(sender : MyTapGesture) {
        
        sender.circleBtn.changeImageAndColor()
        guard let closure =  sender.closure else { return }
        closure()
        
    }
    
    @objc func reloadDataNotification() {
        
        if PlaySong.shared.isPlay() {
            playSongBtn.selectNewIcon()
        }else {
            playSongBtn.selectDefaultIcon()
        }
        presenter.setPlayedMusicIndex(PlaySong.shared.getIndex())
        tableView.reloadData()
        setPlayedSongView()
        
    }

    @objc func otherMusicListStarted() {
        
        presenter.setMusicUrlAndPushPlaySong()
        
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func setupCircleButton() {
        
        nextSongBtn.layer.cornerRadius = nextSongBtn.bounds.width / 2
        nextSongBtn.layer.masksToBounds = true
        
        playSongBtn.layer.cornerRadius = playSongBtn.bounds.width / 2
        playSongBtn.layer.masksToBounds = true
        
        previousSongBtn.layer.cornerRadius = previousSongBtn.bounds.width / 2
        previousSongBtn.layer.masksToBounds = true
        
        
        playSongBtn.setup("play", "pause", UIColor(hexString: "#141921"), .white)
        nextSongBtn.setup("next", nil, UIColor(hexString: "#141921"), nil)
        previousSongBtn.setup("previous", nil, UIColor(hexString: "#141921"), nil)
        
    }
    
    func setupGestureRecognizer() {
        
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
    
    func setupNotificationCenter() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadDataNotification),
            name: Notification.Name("PlayedSong"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadDataNotification),
            name: Notification.Name("StopSong"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(otherMusicListStarted),
            name: Notification.Name("OtherMusicListStarted"),
            object: nil)
        
    }
    
    func hiddenPlayedSong(_ bool: Bool) {
        
        DispatchQueue.main.async {
            self.playedSong.isHidden = bool
        }
        
    }
    
    func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "MusicTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MusicTableViewCell")
        
    }
    
    func setupField() {
        searchBarTxt.searchTextField.delegate = self
        searchBarTxt.delegate = self
    }
    
    func setWillAppear() {
        
        self.navigationController?.isNavigationBarHidden = true
        if let textfield = searchBarTxt.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor(hexString: "#141921")
            textfield.leftView?.tintColor = .systemGray5
        }
        
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        timer?.invalidate()
        let currentText = textField.text ?? ""
        if (currentText as NSString).replacingCharacters(in: range, with: string).count >= 2 {
            timer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(performSearch),
                userInfo: nil,
                repeats: false)
        }
        
        return true
    }
    
    @objc func performSearch() {
        
        guard let term = searchBarTxt.text else { return }
        self.showLoading()
        self.presenter.fetchData(term)
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        if presenter.numberOfMusics == 0 {
            tableView.setEmptyView(title: "You need to search", message: "You can search above")
        }
        return presenter.numberOfMusics
        
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        guard let music = presenter.getMusicForTableCellByIndex(indexPath.row),
              let url = URL(string: music.0) else { return cell }
        cell.cellPresenter = MusicTableViewCellPresenter(
            view: cell,
            music: (url, music.1, music.2, music.3, music.4)
        )
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.presenter.goDetailSong(indexPath.row)
        
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
      if  searchText.count == 0 {
          presenter.removeSongs()
      }
        
    }
    
}

extension HomeViewController {
    
    func setAccessiblityIdentifier() {
        
        searchBarTxt.searchTextField.accessibilityIdentifier = "searchTextField"
        tableView.accessibilityIdentifier = "tableViewFromHome"
        
    }
    
}
