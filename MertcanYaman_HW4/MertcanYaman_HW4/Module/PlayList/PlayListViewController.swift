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
}

final class PlayListViewController: BaseViewController {

    var presenter: PlayListPresenterProtocol!
    
    @IBOutlet weak var playListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        presenter.goAddPlayListScreen()
    }

}

extension PlayListViewController: PlayListViewControllerProtocol {
    
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
        guard let playList = presenter.getPlayListByIndex(indexPath.row) else { return cell }
        cell.setup(playList.name ?? "", "default")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
