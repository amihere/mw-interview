//
//  ListViewModel.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation
import UIKit

class ListViewModel {

    // Tell which cell is needed
    enum CellType {
        case Statistics
        case Chart
    }
    
    var companies:[Int:Company]? = [:]
    var analysis:Analysis?
    var reach:Reach?
    var reachDataLookup:[Int:Int]? // Quick access to reach data.
    var selectedId:Int = 0
    
    weak var delegate: ViewModelDelegate?
    let dataSource: DataSourceProtocol
    
    // Use a custom data source. Useful for testing etc.
    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
        loadData()
    }
    
    init() {
        self.dataSource = ListViewDataSource()
        loadData()
    }
    
    func clearData(){
        self.reachDataLookup?.removeAll()
        self.companies?.removeAll()
        if self.analysis != nil{
            self.analysis!.phrases?.removeAll()
            self.analysis!.phrases = nil
            self.analysis = nil
        }
        if self.reach != nil{
            self.reach!.data?.removeAll()
            self.reach!.data = nil
            self.reach = nil
        }
        self.selectedId = 0
    }
    
    func passDataToVariables(values:DataResponse){
        // Set up data here
        var i:Int = 0
        values.companies?.forEach({ (company) in
            self.companies?[i] = company
            i += 1
        })
        self.analysis = values.analysis
        self.reach = values.reach
        
        setupReachDataLookup()
    }
    
    // ADD the companies indices to the reachDataLookup
    // Their values will give you the correct index inside the data array
    func setupReachDataLookup(){
        let array = self.reach?.data?.map({ $0.companyId })
        self.companies?.forEach({ (key, value) in
            let reachDataIndex = array?.firstIndex(where: {$0 == value.id})
            self.reachDataLookup?[key] = reachDataIndex
        })
    }
    
    private func loadData() {
        delegate?.willLoadData() // Load spinner animation
        fetchData()
    }
    
    private func fetchData(){
        dataSource.fetch { [weak self] result in
            DispatchQueue.main.async {
                guard let reference = self else { return }
                switch result {
                case .failure(_):
                    reference.clearData()
                    
                case .success(let values):
                    reference.passDataToVariables(values: values)
                }
                reference.delegate?.didLoadData()
            }
        }
    }
    
    // Gets the tuple array for the chart
    private func getChartTupleValues() -> [(company:String, value:Double, valueChanged:Double)] {
        var tupleArray = [(company:String, value:Double, valueChanged:Double)]()
        self.companies?.forEach({ (key, companyValue) in
            if let reachData = self.reach?.getReachData(withIndex: key){
                let company = companyValue.name
                let value = reachData.value
                let valueChanged = reachData.change
                
                let tuple = (company:company, value:value, valueChanged:valueChanged)
                tupleArray.append(tuple)
            }
        })
        return tupleArray
    }
}
// MARK: - Public facing methods
extension ListViewModel {
    func getCellType(row:Int) -> CellType{
        return (row % 2 == 0) ? .Statistics: .Chart
    }

    func returnNumberOfRows() -> Int{
        return 2;
    }
    
    func getHeightForRow(row:Int) -> CGFloat{
        if(getCellType(row: row) == .Statistics){
            return 370
        }
        return 420
    }
    
    func initCellForRowAt(row:Int, cell:UITableViewCell){
        if(getCellType(row: row) == .Statistics){
            if let cell = cell as? StatisticsTableViewCell{
                guard let analysis = self.analysis,
                    let values = self.analysis?.phrases?.values else {
                    return
                }
                cell.statistics = Array(values.map{$0})
                cell.headerTuple = (title:analysis.title, byLine:analysis.subTitle)
            }
        }
        else if(getCellType(row: row) == .Chart) {
            if let cell = cell as? ChartTableViewCell{
                guard let reach = self.reach else {
                    return
                }
                cell.values = getChartTupleValues()
                cell.headerTuple = (title:reach.title, byLine:reach.subTitle)
            }
        }
    }
}
