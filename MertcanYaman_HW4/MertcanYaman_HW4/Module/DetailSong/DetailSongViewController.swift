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
    func setupData(_ imageUrl: URL)
}

final class DetailSongViewController: BaseViewController {
    
    var presenter: DetailSongPresenterProtocol!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var innerImageView: UIImageView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(backTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
        self.navigationController?.isNavigationBarHidden = true
        self.title = "Mertcan"
        blurView.layer.cornerRadius = 36
        blurView.clipsToBounds = true
        innerImageView.layer.masksToBounds = false
        innerImageView.layer.shadowOffset = .zero
        innerImageView.layer.shadowColor = UIColor.gray.cgColor
        innerImageView.layer.shadowRadius = 6
        innerImageView.layer.shadowOpacity = 0.8
    }
    
    
    
    func setImage(_ url: URL) {
        self.songImageView.sd_setImage(with: url)
        self.innerImageView.sd_setImage(with: url)
    }
    
    @objc func back() {
        self.presenter.deneme()
        
    }
}

extension DetailSongViewController: DetailSongViewControllerProtocol {
    
    func reloadData() {
        
    }
    
    func setupData(_ imageUrl: URL) {
        self.setImage(imageUrl)
    }   
    
}

