//
//  ListViewController.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: ContainerTableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var model: ListViewModel = {
        let aModel = ListViewModel()
        aModel.delegate = self
        return aModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadUI()
        loadViewModel()
    }
    
    func loadUI(){
        let statNib = UINib.init(nibName: StatisticsTableViewCell.nibName, bundle: nil)
        tableView.register(statNib, forCellReuseIdentifier: StatisticsTableViewCell.reuseCellIdentifier)
        
        let chartNib = UINib.init(nibName: ChartTableViewCell.nibName, bundle: nil)
        tableView.register(chartNib, forCellReuseIdentifier: ChartTableViewCell.reuseCellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadViewModel(){
        
    }
}

extension ListViewController: ViewModelDelegate {
    
    func willLoadData() {
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
            UIView.animate(withDuration: 0.1, animations: {
                self.tableView.alpha = 0
            })
        }
    }
    
    func didLoadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimating()
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.alpha = 1
            })
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.returnNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = model.getCellType(row: indexPath.row)
        
        switch type{
        
        case .Chart:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.reuseCellIdentifier, for: indexPath) as! ChartTableViewCell
            model.initCellForRowAt(row: indexPath.row, cell: cell)
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableViewCell.reuseCellIdentifier, for: indexPath) as! StatisticsTableViewCell
            model.initCellForRowAt(row: indexPath.row, cell: cell)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model.getHeightForRow(row:indexPath.row)
    }
}

// Utility functions
extension ListViewController{
    
}
