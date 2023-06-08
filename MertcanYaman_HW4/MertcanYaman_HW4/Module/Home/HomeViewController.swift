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
}

final class HomeViewController: BaseViewController {
    
    var timer: Timer?
    var presenter: HomePresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarTxt: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.viewWillAppear()
    }    
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicTableViewCell")
    }
    
    func setupField() {
        searchBarTxt.searchTextField.delegate = self
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
        guard let music = presenter.getMusicForTableCellByIndex(indexPath.row),
              let url = URL(string: music.0) else { return cell }
        cell.setup(url, music.1, music.2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.goDetailSong(indexPath.row)
    }
}

