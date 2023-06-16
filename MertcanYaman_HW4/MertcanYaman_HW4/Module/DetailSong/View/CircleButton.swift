//
//  CircleButton.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 9.06.2023.
//

import UIKit

final class CircleButton: UIView {
    
    @IBOutlet var outerView: UIView!
    @IBOutlet weak var btnImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    private var view: UIView!
    
    var defaultImage: UIImage?
    var newImage: UIImage?
    var defaultColor: UIColor?
    var newColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(
        _ imageNameDefault: String,
        _ imageNameNew: String?,
        _ backgroundColorDefault: UIColor,
        _ backgroundColorNew: UIColor?
    ) {
        self.configureView()
        self.defaultImage = UIImage(named: imageNameDefault)
        
        if let imageName = imageNameNew {
            self.newImage = UIImage(named: imageName)
        }
        
        self.defaultColor = backgroundColorDefault
        self.newColor = backgroundColorNew
        btnImageView.image = defaultImage
        outerView.backgroundColor = defaultColor
    }
    
    func changeImageAndColor() {
        
        if let newImage {
            DispatchQueue.main.async {
                if self.btnImageView.image == self.defaultImage {
                    self.btnImageView.image = newImage
                }else {
                    self.btnImageView.image = self.defaultImage
                }
            }
        }
        
        if let newColor {
            DispatchQueue.main.async {
                if self.outerView.backgroundColor == self.defaultColor {
                    self.outerView.backgroundColor = newColor
                }else {
                    self.outerView.backgroundColor = self.defaultColor
                }
            }
        }
        
    }
    
    func selectNewIcon() {
        
        if let newColor {
            DispatchQueue.main.async {
                self.outerView.backgroundColor = newColor
                self.btnImageView.image = self.newImage
            }
        }
        
    }
    
    func selectDefaultIcon() {
        
        DispatchQueue.main.async {
            self.outerView.backgroundColor = self.defaultColor
            self.btnImageView.image = self.defaultImage
        }
        
    }
    
    private func configureView() {
        
        guard let nibView = loadViewFromNib() else {return }
        containerView = view
        bounds = nibView.frame
        addSubview(nibView)
        
    }
    
    private func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let name = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self)[0] as! UIView
        return view
        
    }
    
}
