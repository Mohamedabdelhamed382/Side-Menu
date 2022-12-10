//
//  ViewController.swift
//  Side Menu
//
//  Created by MOHAMED ABD ELHAMED AHMED on 10/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgBackground: UIImageView!
    @IBOutlet var swipGesture: UISwipeGestureRecognizer!
    var option: [Option] = [
        Option(title: "Home", segua: "HomeSegue"),
        Option(title: "Settings", segua: "SettingsSegue"),
        Option(title: "Profile", segua: "ProfileSegue"),
        Option(title: "TermsAndConditions", segua: "TermsAndConditionsSegue"),
        Option(title: "Privacy", segua: "PrivacySegue")
    ]
    
    var menu = false
    let screen = UIScreen.main.bounds
    var home = CGAffineTransform()
    
    
    struct Option {
        var title = String()
        var segua = String()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        home = containerView.transform
    }
    
    func showMenu() {
        self.containerView.layer.cornerRadius = 40
        self.bgBackground.layer.cornerRadius = self.containerView.layer.cornerRadius
        let x = screen.width * 0.8
        let orginalTransform = self.containerView.transform
        let scaleTransform = orginalTransform.scaledBy(x: 0.8, y: 0.8)
        let scaleAndTranslatedTransform = scaleTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = scaleAndTranslatedTransform
        }
    }
    
    func hidMenu() {
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = self.home
            self.containerView.layer.cornerRadius = 0
            self.bgBackground.layer.cornerRadius = self.containerView.layer.cornerRadius
        }
    }
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        if menu == false && swipGesture.direction == .right {
            showMenu()
            menu = true
        }
    }
    
    @IBAction func hideMenu(_ sender: UITapGestureRecognizer) {
        if menu == true {
            hidMenu()
            menu = false
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.backgroundColor = .clear
        cell.descriptionLabel.text = option[indexPath.row].title
        cell.descriptionLabel.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
        currentCell.alpha = 0.5
        
        UIView.animate(withDuration: 1) {
            currentCell.alpha = 1
        }
        
        self.parent?.performSegue(withIdentifier: option[indexPath.row].segua, sender: self)
    }
}
