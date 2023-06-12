//
//  AddPlayListPopUp.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 12.06.2023.
//

import UIKit

protocol AddPlayListPopUpProtocol: AnyObject {
    func reloadData()
}

final class AddPlayListPopUp: UIViewController {

    var presenter: AddPlayListPopUpPresenterProtocol!
    
    @IBOutlet weak var playListTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    
    init() {
        super.init(nibName: "AddPlayListPopUp", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        presenter.viewDidLoad()
        let backTap = UIGestureRecognizer(target: self, action: #selector(hide))
        backView.addGestureRecognizer(backTap)
        playListTableView.delegate = self
        playListTableView.dataSource = self
    }

    @IBAction func btnClicked(_ sender: Any) {
        self.hide()
    }
    
    func configView(){
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: true) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    @objc func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
            self.removeFromParent()
        }
    }
}

extension AddPlayListPopUp: AddPlayListPopUpProtocol {
    
    func reloadData() {
        playListTableView.reloadData()
    }
    
}

extension AddPlayListPopUp: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfPlayList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let name = presenter.getPlayListNameByIndex(indexPath.row) else { return cell }
        cell.textLabel?.text = name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
}
