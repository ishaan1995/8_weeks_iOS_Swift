//
//  ViewController.swift
//  HelloWorld UI via Code
//
//  Created by Ishaan Kakkar on 20/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    let refreshBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.setTitle(" 🔄 Refresh ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self,
            action: #selector(refreshBtnPressed),
            for: UIControl.Event.touchUpInside
        )
        return button
    }()
    
    let currentTempView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48)
        label.text = "⛅️ 21°C"
        label.textAlignment = .center
        return label
    }()

    let minMaxView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Min: 11°C  | Max: 22°C"
        label.textAlignment = .center
        return label
    }()
    
    let placeView: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "🏠 New Delhi, India"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }
    
    @objc func refreshBtnPressed(sender: UIButton!) {
        sender.setTitle("Coming Soon", for: .normal)
    }
    
    func setupUI() {
        self.setupViewPositions()
    }
}

extension ViewController {
    func setupViewPositions() {
        setupRefreshBtn()
        setupMinMaxView()
        setupCurrentTempView()
        setupPlaceView()
    }
    
    func setupRefreshBtn() {
        refreshBtn.frame = CGRect(
            x: self.view.center.x - 60,
            y: self.view.center.y,
            width: 120,
            height: 40
        )
        view.addSubview(refreshBtn)
    }
    
    func setupMinMaxView() {
        let padding: CGFloat = 16
        let parentWidth = self.view.frame.width
        let centerX = parentWidth / 2 - padding
        let height: CGFloat = 20
        let yBottomPadding: CGFloat = height + 44
        minMaxView.frame = CGRect(
            x: self.view.center.x - centerX,
            y: refreshBtn.frame.origin.y - yBottomPadding,
            width: parentWidth - (2*padding),
            height: height
        )
        view.addSubview(minMaxView)
    }
    
    func setupCurrentTempView() {
        let padding: CGFloat = 16
        let parentWidth = self.view.frame.width
        let centerX = parentWidth / 2 - padding
        let height: CGFloat = 60
        let yBottomPadding: CGFloat = height + 16
        currentTempView.frame = CGRect(
            x: self.view.center.x - centerX,
            y: minMaxView.frame.origin.y - yBottomPadding,
            width: parentWidth - (2*padding),
            height: height
        )
        view.addSubview(currentTempView)
    }
    
    func setupPlaceView() {
        let padding: CGFloat = 16
        let parentWidth = self.view.frame.width
        let centerX = parentWidth / 2 - padding
        let height: CGFloat = 20
        let yBottomPadding: CGFloat = height + 16
        placeView.frame = CGRect(
            x: self.view.center.x - centerX,
            y: currentTempView.frame.origin.y - yBottomPadding,
            width: parentWidth - (2*padding),
            height: height
        )
        view.addSubview(placeView)
    }
}

extension UIView {
    func addTestingBorder() {
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.red.cgColor
    }
}
