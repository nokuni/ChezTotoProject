//
//  MenuViewController.swift
//  ChezTotoProject
//
//  Created by Yann Christophe Maertens on 22/11/2023.
//

import UIKit
import Utility_Toolbox

class MenuViewController: UIViewController {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    let apiManager = APIManager()
    let url = "https://simplonline-v3-prod.s3.eu-west-3.amazonaws.com/media/file/json/source-655c8d8eb8a23595571446.json"
    
    var menus: [RestaurantMenu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        safeArea = view.layoutMarginsGuide
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMenus()
    }
    
    func setMenus() {
        Task {
            self.menus = try await apiManager.get(url: url)
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        menus.isEmpty ? "" : menus[section].name
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menus.isEmpty ? 0 : menus[section].dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let section = menus[indexPath.section]
        let headline = section.dishes[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(headline.name)"
        content.secondaryText = "\(headline.description)\n\(headline.price)€"
        content.textProperties.alignment = .justified
        content.image = UIImage(named: headline.pictureName)
        content.imageProperties.cornerRadius = 5
        content.imageProperties.maximumSize = CGSize(width: 112, height: 86)
        
        cell.contentConfiguration = content
        
        return cell
    }
    
}

extension MenuViewController: UITableViewDelegate {
    
}
