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
}

final class DetailPlayListViewController: BaseViewController {

    var presenter: DetailPlayListPresenterProtocol!
    
    @IBOutlet weak var playListTableView: UITableView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var playListTitle: UILabel!
    @IBOutlet weak var listImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backPage))
        backImage.addGestureRecognizer(backTap)
        
        playListTableView.delegate = self
        playListTableView.dataSource = self
        playListTableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicTableViewCell")
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    @objc func backPage() {
        presenter.goOtherPage(.goPreviousPage)
    }
}

extension DetailPlayListViewController: DetailPlayListViewControllerProtocol {
    
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
            tableView.setEmptyView(title: "Song Not Found", message: "You can quickly access the songs later by adding them.")
        }
        return presenter.numberOfSavedMusics
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        guard let music = presenter.getSavedMusicForTableCellByIndex(indexPath.row),
              let url = URL(string: music.0) else { return cell }
        cell.setup(url, music.1, music.2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteSong(indexPath.row)
        }else {
            print("Merhaba")
        }
    }
    
}
