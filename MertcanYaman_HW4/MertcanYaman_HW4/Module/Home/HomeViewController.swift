//
//  HomeViewController.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
    func reloadData()
}

final class HomeViewController: BaseViewController {
    
    var timer: Timer?
    var presenter: HomePresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarTxt: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarTxt.searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if let textfield = searchBarTxt.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor(hexString: "#141921")
            textfield.leftView?.tintColor = .systemGray5
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension HomeViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        timer?.invalidate()
        let currentText = textField.text ?? ""
        if (currentText as NSString).replacingCharacters(in: range, with: string).count >= 2 {

             timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performSearch), userInfo: nil, repeats: false)
        }

        return true
    }

    @objc func performSearch() {
        guard let term = searchBarTxt.text else { return }
        self.showLoading()
        self.presenter.fetchData(term, .song)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfMusics
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        guard let music = presenter.getMusicByIndex(indexPath.row),
              let imageUrl = music.artworkUrl100,
              let url = URL(string: imageUrl),
              let title = music.trackName,
              let content = music.artistName else { return cell }
        cell.setup(url, title, content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

