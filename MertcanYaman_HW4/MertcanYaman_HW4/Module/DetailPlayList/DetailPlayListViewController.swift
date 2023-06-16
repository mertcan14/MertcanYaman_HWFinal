//
//  DetailPlayListViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 12.06.2023.
//

import UIKit

protocol DetailPlayListViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
    
    func setTitle(_ name: String)
    func reloadData()
    func setupTableView()
    func setupGestureRecognizer()
    func setupNotificationCenter()
    
}

final class DetailPlayListViewController: BaseViewController {

    var presenter: DetailPlayListPresenterProtocol!
    
    @IBOutlet weak var playListTableView: UITableView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var playListTitle: UILabel!
    @IBOutlet weak var listImageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        presenter.viewWillAppear()
        
    }
    
    @objc func backPage() {
        
        presenter.goOtherPage(.goPreviousPage)
        
    }
    
    @objc func otherMusicListStarted() {
        
        presenter.setMusicUrlAndPushPlaySong()
        
    }
    
    @objc func reloadDataNotification() {
        
        playListTableView.reloadData()
        
    }
}

extension DetailPlayListViewController: DetailPlayListViewControllerProtocol {
    
    func setupGestureRecognizer() {
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backPage))
        backImage.addGestureRecognizer(backTap)
        
    }
    
    func setupNotificationCenter() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(otherMusicListStarted),
            name: Notification.Name("OtherMusicListStarted"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadDataNotification),
            name: Notification.Name("PlayedSong"),
            object: nil
        )
    }
    
    func setupTableView() {
        
        playListTableView.delegate = self
        playListTableView.dataSource = self
        playListTableView.register(
            UINib(nibName: "MusicTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MusicTableViewCell"
        )
        
    }
    
    func reloadData() {
        
        playListTableView.reloadData()
        
    }
    
    func setTitle(_ name: String) {
        
        self.playListTitle.text = name
        
    }
    
}

extension DetailPlayListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if presenter.numberOfSavedMusics == 0 {
            tableView.setEmptyView(
                title: "Song Not Found",
                message: "You can quickly access the songs later by adding them."
            )
        }
        return presenter.numberOfSavedMusics
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        guard let music = presenter.getSavedMusicForTableCellByIndex(indexPath.row),
              let url = URL(string: music.0) else { return cell }
        cell.cellPresenter = MusicTableViewCellPresenter(
            view: cell,
            music: (url, music.1, music.2, music.3, music.4)
        )
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            presenter.deleteSong(indexPath.row)
        }
        
    }
    
}
